--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Responsible for detecting and loading plugins.
---
--- @class PluginManager
---
local CLASS = {}
CLASS.__index = CLASS



--- @type table<string, PluginInformation>
CLASS._Located = {}

--- @type table<string, Plugin>
CLASS._Loaded = {}





--- Determines if a given plugin is loaded.
---
--- @param identifier string the plugin's identifier
--- @return boolean is loaded
---
function CLASS:IsPluginLoaded(identifier)
	return self:FindPlugin(identifier) ~= nil
end


--- Finds a loaded plugin by it's identifier.
---
--- @param identifier string the identifier
--- @return Plugin|nil the plugin
---
function CLASS:FindPlugin(identifier)
	return self._Loaded[identifier]
end





--- Determines if a given plugin is available.
---
--- @param identifier string the plugin's identifier
--- @return boolean is available
---
function CLASS:IsPluginAvailable(identifier)
	return self:FindPluginInfo(identifier) ~= nil
end


--- Finds a located plugin by it's identifier.
---
--- @param identifier string the identifier
--- @return PluginInformation|nil the plugin info
---
function CLASS:FindPluginInfo(identifier)
	return self._Located[identifier]
end





--- Locates all available plugins.
---
function CLASS:LocatePlugins()
	Jet:Info("Locating plugins...")
	local files, dirs = file.Find("plugins/*", "LUA")
	for _, dir in ipairs(dirs) do
		Jet:Debug("- " .. dir)
		assert(table.HasValue(files, dir .. ".lua"), "Plugin '" .. dir .. "' found, but no '" .. dir .. ".lua' exists.")
		self:LocatePlugin(dir)
	end
	Jet:Info("Located " .. table.Count(self._Located) .. " plugins.")
end


--- Locates a single plugin by the given folder.
---
--- @param folder string the folder name
---
function CLASS:LocatePlugin(folder)
	local infoRaw = include("plugins/" .. folder .. ".lua")
	local info = self:ValidatePluginInformation(infoRaw)
	info.FolderName = folder
	self._Located[folder] = info
	AddCSLuaFile("plugins/" .. folder .. ".lua")
end





--- Validates the given raw information and creates a proper [PluginInformation].
---
---
--- @param raw any the raw information
--- @return PluginInformation the proper information
---
function CLASS:ValidatePluginInformation(raw)
	-- Assert GroupID
	assert(isstring(raw["GroupID"]) and raw["GroupID"] ~= "", "GroupID must be provided.")

	-- Assert PluginID
	assert(isstring(raw["PluginID"]) and raw["PluginID"] ~= "", "PluginID must be provided.")

	-- Assert Version
	assert(isstring(raw["Version"]) and raw["Version"] ~= "", "Version must be provided.")
	local version = Jet:ParseVersion(raw["Version"])
	assert(version ~= nil, "Version '" .. raw["Version"] .. "' is in illegal format.")

	-- Assert Name
	assert(isstring(raw["Name"]) and raw["Name"] ~= "", "Name must be provided.")

	-- Assert Dependencies
	local dependencies = {}
	for _, str in ipairs(raw["Dependencies"] or {}) do
		local dependency = Jet:ParseDependency(str)
		assert(dependency ~= nil, "Dependency '" .. str .. "' is in illegal format.")
		table.insert(dependencies, dependency)
	end

	-- Assert Soft-Dependencies
	local softDependencies = {}
	for _, str in ipairs(raw["SoftDependencies"] or {}) do
		local dependency = Jet:ParseDependency(str)
		assert(dependency ~= nil, "Soft-Dependency '" .. str .. "' is in illegal format.")
		table.insert(softDependencies, dependency)
	end

	--- @type PluginInformation
	local meta = debug.getregistry()["Jet:PluginInformation"]

	return setmetatable({

		GroupID = raw["GroupID"],
		PluginID = raw["PluginID"],
		Version = version,
		Name = raw["Name"],
		Description = raw["Description"] or meta.Description,
		Authors = raw["Authors"] or meta.Authors,

		EntrypointServer = raw["EntrypointServer"] or meta.EntrypointServer,
		EntrypointShared = raw["EntrypointShared"] or meta.EntrypointShared,
		EntrypointClient = raw["EntrypointClient"] or meta.EntrypointClient,

		AutoDownloadSharedFiles = raw["AutoDownloadSharedFiles"] == true,
		AutoDownloadClientFiles = raw["AutoDownloadClientFiles"] == true,

		AutoLoadEffects = raw["AutoLoadEffects"] == true,
		AutoLoadEntities = raw["AutoLoadEntities"] == true,
		AutoLoadWeapons = raw["AutoLoadWeapons"] == true,
		AutoLoadLibraries = raw["AutoLoadLibraries"] == true,
		AutoLoadClasses = raw["AutoLoadClasses"] == true,

		LoadOrder = raw["LoadOrder"] or meta.LoadOrder,

		Dependencies = dependencies,
		SoftDependencies = softDependencies,

		Private = raw["Private"] == true,
		Homepage = raw["Homepage"],
		License = raw["License"],
		Bugs = raw["Bugs"],
		Funding = raw["Funding"],
		Repository = raw["Repository"],

	}, meta)
end





--- Loads all available plugins.
---
function CLASS:LoadPlugins()
	Jet:Info("Loading plugins...")
	print("")
	for _, info in pairs(self._Located) do
		self:LoadPlugin(info)
	end
	Jet:Info("Loaded " .. table.Count(self._Loaded) .. " plugins.")
end


--- Loads the given plugin.
---
--- @param info PluginInformation the plugin to enable
---
function CLASS:LoadPlugin(info)

	-- Is loaded?
	local plugin = self:FindPlugin(info:Identifier())
	if plugin ~= nil then
		plugin:Debug("Already loaded.")
		return
	end

	-- Create plugin
	plugin = Jet:CreatePlugin(info)

	-- Enable dependencies
	plugin:Debug("Resolving dependencies...")
	for _, dependency in ipairs(info.Dependencies) do
		local depPlugin = self:FindPluginInfo(dependency:GetDependencyIdentifier())
		if depPlugin ~= nil then
			if dependency.Match.Matches(dependency.Version, depPlugin.Version) then
				plugin:Debug("- " .. dependency:GetDependencyIdentifier())
				self:LoadPlugin(depPlugin)
			else
				plugin:Severe("Dependency " .. dependency:GetDependencyIdentifier() .. " does not satisfy required version.")
				plugin:Error("- Required: " .. tostring(dependency.Version))
				plugin:Error("- Available: " .. tostring(depPlugin.Version))
				return
			end
		else
			plugin:Severe("Dependency " .. dependency:GetDependencyIdentifier() .. " is not available.")
			return
		end
	end

	-- Enable soft-dependencies
	plugin:Debug("Resolving soft-dependencies...")
	for _, dependency in ipairs(info.SoftDependencies) do
		local depPlugin = self:FindPluginInfo(dependency:GetDependencyIdentifier())
		if depPlugin ~= nil then
			if dependency.Match:Matches(dependency.Version, depPlugin.Version) then
				plugin:Debug("- " .. dependency:GetDependencyIdentifier() .. " (AVAILABLE)")
				self:LoadPlugin(depPlugin)
			else
				plugin:Debug("- " .. dependency:GetDependencyIdentifier() .. " (INVALID VERSION)")
			end
		else
			plugin:Debug("- " .. dependency:GetDependencyIdentifier() .. " (NOT AVAILABLE)")
		end
	end

	-- Register plugin
	self._Loaded[info:Identifier()] = plugin

	-- Pre-Boot
	local start = SysTime()
	plugin:Info("Loading plugin...")

	-- Download shared files
	if info.AutoDownloadSharedFiles then
		plugin:Debug("- Downloading shared files...")
		self:DownloadSharedFiles(info)
	end

	-- Download client files
	if info.AutoDownloadClientFiles then
		plugin:Debug("- Downloading client files...")
		self:DownloadClientFiles(info)
	end

	-- Boot process
	for _, boot in ipairs(info.LoadOrder) do
		if boot == "classes" then
			plugin:Debug("- Loading classes...")
			self:LoadPluginClasses(info)

		elseif boot == "libraries" then
			plugin:Debug("- Loading libraries...")
			self:LoadPluginLibraries(info)

		elseif boot == "shared" then
			plugin:Debug("- Loading shared...")
			self:LoadPluginShared(info)

		elseif boot == "server" then
			if SERVER ~= true then goto CONTINUE end
			plugin:Debug("- Loading server-side...")
			self:LoadPluginServer(info)

		elseif boot == "client" then
			if CLIENT ~= true then goto CONTINUE end
			plugin:Debug("- Loading client-side...")
			self:LoadPluginClient(info)

		elseif boot == "weapons" then
			plugin:Debug("- Loading weapons...")
			self:LoadPluginWeapons(info)

		elseif boot == "entities" then
			plugin:Debug("- Loading entities...")
			self:LoadPluginEntities(info)

		elseif boot == "effects" then
			plugin:Debug("- Loading effects...")
			self:LoadPluginEffects(info)

		else
			error("Unknown boot step: '" .. boot .. "'")
		end

		::CONTINUE::
	end
	plugin:Info("Enabled " .. info.Name .. " v" .. tostring(info.Version) .. " - took " .. Jet:FormatTimeLength(SysTime() - start))

	-- Print a nice empty line
	print("")

end





--- @param fileName string
--- @return boolean
function CLASS:IsServerFile(fileName)
	return string.StartWith(fileName, "sv_") or string.StartWith(fileName, "server")
end

--- @param fileName string
--- @return boolean
function CLASS:IsClientFile(fileName)
	return string.StartWith(fileName, "cl_") or string.StartWith(fileName, "client")
end

--- @param fileName string
--- @return boolean
function CLASS:IsSharedFile(fileName)
	return not self:IsServerFile(fileName) and not self:IsClientFile(fileName)
end





--- @param info PluginInformation the plugin information
---
function CLASS:DownloadSharedFiles(info)
	file.FindRecursive("plugins/" .. info.FolderName .. "/", "*.lua", "LUA", function(dir, file)
		if self:IsSharedFile(file) then
			AddCSLuaFile(dir .. file)
		end
	end)
end


--- @param info PluginInformation the plugin information
---
function CLASS:DownloadClientFiles(info)
	file.FindRecursive("plugins/" .. info.FolderName .. "/", "*.lua", "LUA", function(dir, file)
		if self:IsClientFile(file) then
			AddCSLuaFile(dir .. file)
		end
	end)
end





function CLASS:FileHandlingConsumer()
	return function(dir, file)
		if self:IsClientFile(file) then
			if CLIENT == true then
				include(dir .. "/" .. file)
			end
			if SERVER == true then
				AddCSLuaFile(dir .. "/" .. file)
			end
		elseif self:IsServerFile(file) then
			if SERVER == true then
				include(dir .. "/" .. file)
			end
		else
			AddCSLuaFile(dir .. "/" .. file)
			include(dir .. "/" .. file)
		end
	end
end





--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginClasses(info)
	local pathName = "plugins/" .. info.FolderName .. "/classes/"
	file.FindRecursive(pathName, "*.lua", "LUA", self:FileHandlingConsumer())
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginClient(info)
	assert(CLIENT == true, "PluginManager::LoadPluginClient cannot be invoked in non-client realm.")
	letNN(info.EntrypointClient, function(it)
		if file.Exists("plugins/" .. info.FolderName .. "/" .. it, "LUA") then
			include("plugins/" .. info.FolderName .. "/" .. it)
		end
	end)
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginEffects(info)
	-- TODO
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginEntities(info)
	-- TODO
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginLibraries(info)
	local pathName = "plugins/" .. info.FolderName .. "/libraries/"
	file.FindRecursive(pathName, "*.lua", "LUA", self:FileHandlingConsumer())
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginServer(info)
	assert(SERVER == true, "PluginManager::LoadPluginServer cannot be invoked in non-server realm.")
	letNN(info.EntrypointServer, function(it)
		if file.Exists("plugins/" .. info.FolderName .. "/" .. it, "LUA") then
			include("plugins/" .. info.FolderName .. "/" .. it)
		end
	end)
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginShared(info)
	letNN(info.EntrypointShared, function(it)
		if file.Exists("plugins/" .. info.FolderName .. "/" .. it, "LUA") then
			include("plugins/" .. info.FolderName .. "/" .. it)
		end
	end)
end


--- @param info PluginInformation the plugin information
---
function CLASS:LoadPluginWeapons(info)
	-- TODO
end





-- Register class.
debug.getregistry()["Jet:PluginManager"] = CLASS
