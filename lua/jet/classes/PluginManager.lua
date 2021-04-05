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
	-- TODO
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
		-- TODO
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

		elseif boot == "server" and SERVER == true then
			plugin:Debug("- Loading server-side...")
			self:LoadPluginServer(info)

		elseif boot == "client" and CLIENT == true then
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
	end
	plugin:Info("Enabled " .. info.Name .. " v" .. info.Version .. " - took " .. (SysTime() - start) .. "s")

end





function CLASS:LoadPluginClasses(info)
end



function CLASS:LoadPluginClient(info)
	assert(CLIENT == true, "PluginManager::LoadPluginClient cannot be invoked in non-client realm.")
end



function CLASS:LoadPluginEffects(info)
end



function CLASS:LoadPluginEntities(info)
end



function CLASS:LoadPluginLibraries(info)
end



function CLASS:LoadPluginServer(info)
	assert(SERVER == true, "PluginManager::LoadPluginServer cannot be invoked in non-server realm.")
end



function CLASS:LoadPluginShared(info)
end



function CLASS:LoadPluginWeapons(info)
end





-- Register class.
debug.getregistry()["Jet:PluginManager"] = CLASS
