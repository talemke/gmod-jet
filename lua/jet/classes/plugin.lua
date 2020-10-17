
--[[
	Jet -> Plugin Class (Shared)
	by Tassilo (@TASSIA710)

	This file contains the plugin class.
--]]

local PLUGIN = {}
PLUGIN.__index = PLUGIN
PLUGIN._meta = nil
PLUGIN._path = nil
PLUGIN._dependencies = {}
PLUGIN._dependenciesSoft = {}
PLUGIN._version = nil
PLUGIN._loaded = false





--- Initializes the plugin, including reading the meta file of the pluign.
-- Meta information about a plugin is not available before it is initialized.
-- @internal
function PLUGIN:Init()
	-- Assert
	assert(self._path ~= nil, "Path not specified.")
	assert(self._meta == nil, "Plugin already initialized.")

	-- PreInitialize Hook
	--- Called when a plugin is about to be initialized.
	-- Initializing means that the meta file is about to be read.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginInitialize", self)

	-- Define paths
	local pluginPath = "plugins/" .. self._path
	local metaFile = pluginPath .. "/plugin.lua"

	-- Check plugin.json
	if not file.Exists(metaFile, "LUA") then
		return false, "plugin.lua not found"
	end

	-- Load meta
	local meta = include(metaFile)
	if not meta then
		return false, "Invalid plugin.lua"
	end

	-- Download meta
	if SERVER then
		AddCSLuaFile(metaFile)
	end

	-- Verify meta fields
	if not meta.author then
		return false, "Author not provided."
	end
	if not meta.name then
		return false, "Name not provided."
	end
	if not meta.description then
		meta.description = ""
	end
	if not meta.version then
		meta.version = "1.0.0"
	end
	if not meta.disabled then
		meta.disabled = false
	end
	if not meta.soft_dependencies then
		meta.soft_dependencies = {}
	end

	-- Parse version
	self._version = jet.ParseVersion(meta.version)
	if not self._version then
		return false, "Cannot determine version: " .. meta.version
	end

	-- Parse dependencies
	self._dependencies = {}
	meta.dependencies = meta.dependencies or {}
	for _, dependency in pairs(meta.dependencies) do
		local parsed = jet.ParseDependency(dependency)
		if parsed then
			table.insert(self._dependencies, parsed)
		else
			return false, "Cannot determine dependency: " .. dependency
		end
	end

	-- Parse soft-dependencies
	self.soft_dependencies = {}
	meta.soft_dependencies = meta.soft_dependencies or {}
	for _, dependency in pairs(meta.soft_dependencies) do
		local parsed = jet.ParseDependency(dependency)
		if parsed then
			table.insert(self._dependenciesSoft, parsed)
		else
			return false, "Cannot determine soft-dependency: " .. dependency
		end
	end

	-- Download files
	AddCSLuaFileSafe(pluginPath .. "/shared.lua")
	AddCSLuaFileSafe(pluginPath .. "/test.lua")
	AddCSLuaFileSafe(pluginPath .. "/cl_init.lua")
	AddCSLuaFileSafe(pluginPath .. "/sh_test.lua")
	AddCSLuaFileSafe(pluginPath .. "/cl_test.lua")
	AddCSLuaFileSafe(pluginPath .. "/sh_unload.lua")
	AddCSLuaFileSafe(pluginPath .. "/cl_unload.lua")

	-- Store
	self._meta = meta

	-- PostInitialize Hook
	--- Called when a plugin has been successfully initialized.
	-- @param plugin [Plugin] - he plugin
	hook.Run("PluginInitialized", self)
	return true
end





--- Loads this plugin. This executes the `shared.lua`, `sv_init.lua` and
-- `cl_init.lua` files in this order.
-- @returns success [boolean] - successfully loaded?
-- @returns reason [string] - the reason the load failed, or `nil`
function PLUGIN:Load()
	-- Assert
	assert(self._meta ~= nil, "Plugin not initialized.")
	assert(self._path ~= nil, "Plugin not initialized.")

	-- Disabled?
	if self:IsDisabled() then
		return false, "Plugin is disabled."
	end

	-- Already loaded?
	if self._loaded then
		return true
	end

	-- PreLoad Hook
	--- Called when a plugin is about to be loaded.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginLoad", self)

	-- Prepare
	local pluginPath = "plugins/" .. self._path

	-- Resolve dependencies
	do
		local success, reason = self:ResolveDependencies()
		if not success then
			return false, reason
		end
	end

	-- Resolve soft-dependencies
	do
		local success, reason = self:ResolveSoftDependencies()
		if not success then
			return false, reason
		end
	end

	-- Load Shared
	IncludeSafe(pluginPath .. "/shared.lua")

	-- Load ServerSide
	if SERVER then
		IncludeSafe(pluginPath .. "/sv_init.lua")
	end

	-- Load ClientSide
	if CLIENT then
		IncludeSafe(pluginPath .. "/cl_init.lua")
	end

	-- Cleanup
	self._loaded = true

	-- PostLoad Hook
	--- Called when a plugin has been successfully loaded.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginLoaded", self)
end





--- Unloads this plugin. Will also execute the `sh_unload.lua`, `sv_unload.lua`
-- and `cl_unload.lua` files in this order.
function PLUGIN:Unload()
	-- Assert
	assert(self._meta ~= nil, "Plugin not initialized.")
	assert(self._path ~= nil, "Plugin not initialized.")
	assert(self._loaded, "Plugin not loaded.")

	-- PreUnload Hook
	--- Called when a plugin is about to be unloaded.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginUnload", self)

	-- Prepare
	local pluginPath = "plugins/" .. self._path

	-- Unload Shared
	IncludeSafe(pluginPath .. "/sh_unload.lua")

	-- Unload ServerSide
	if SERVER then
		IncludeSafe(pluginPath .. "/sv_unload.lua")
	end

	-- Unload ClientSide
	if CLIENT then
		IncludeSafe(pluginPath .. "/cl_unload.lua")
	end

	-- Cleanup
	self._loaded = false

	-- PostUnload Hook
	--- Called when a plugin has been successfully unloaded.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginUnloaded", self)
end





--- Tests this plugin. Will try to execute the `test.lua` file.
-- @blocking
function PLUGIN:Test()
	-- Assert
	assert(self._meta ~= nil, "Plugin not initialized.")
	assert(self._path ~= nil, "Plugin not initialized.")
	assert(self._loaded, "Plugin not loaded.")

	-- Prepare
	local pluginPath = "plugins/" .. self._path

	-- Has test?
	if not file.Exists(pluginPath .. "/test.lua", "LUA") then
		return false
	end

	-- PreTest Hook
	--- Called when a plugin is about to be tested.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginTest", self)

	-- Test
	local test = CompileFile(pluginPath .. "/test.lua")
	test()

	-- PostUnload Hook
	--- Called when a plugin has been successfully tested.
	-- @param plugin [Plugin] - the plugin
	hook.Run("PluginTested", self)
	return true
end





--- Returns whether this plugin can be tested. A plugin can be tested if it
-- contains a `test.lua` file in its root.
-- @returns testable [boolean] - can be tested
function PLUGIN:IsTestable()
	return file.Exists("plugins/" .. self._path .. "/test.lua", "LUA")
end

--- Returns whether this plugin is loaded.
-- @returns loaded [boolean] - is loaded
function PLUGIN:IsLoaded()
	return self._loaded
end

--- Returns the path name of this plugin (e.g. 'cli').
-- @returns pathName [string] - the path name
function PLUGIN:GetPathName()
	return self._path
end

--- Returns the identifier of this plugin. The identifier consists of the
-- plugin author and the plugin name (e.g. `TASSIA710/Generic`).
-- @returns identifier [string] - the identifier
function PLUGIN:GetIdentifier()
	return self._meta.author .. "/" .. self._meta.name
end

--- Returns a table of the dependencies of this plugin.
-- @returns dependencies [table] - the dependencies
function PLUGIN:GetDependencies()
	return self._dependencies
end

--- Returns a table of the soft-dependencies of this plugin.
-- @returns softDependencies [table] - the soft-dependencies
function PLUGIN:GetSoftDependencies()
	return self._dependenciesSoft
end

--- Returns the version of this plugin.
-- @returns version [Version] - the version
function PLUGIN:GetVersion()
	return self._version
end

--- Returns whether this plugin has been forcefully disabled, e.g. via the meta file.
-- @returns disabled [boolean] - is disabled
function PLUGIN:IsDisabled()
	if self._meta and self._meta.disabled then
		return true
	else
		return false
	end
end

--- Attempts to resolve and load all dependencies of this plugin.
-- @returns success [boolean] - whether dependencies were resolved successfully
-- @returns reason [string] - the reason it failed, or `nil`
-- @internal
function PLUGIN:ResolveDependencies()
	for _, dependency in pairs(self:GetDependencies()) do
		local pl = jet.GetPlugin(dependency.identifier)

		-- Check available
		if not pl then
			return false, "Dependency " .. dependency.identifier .. " is unavailable."
		end

		-- Check version compability
		if not pl:GetVersion():IsCompatible(dependency.version) then
			return false, "Required version of " .. dependency.identifier .. " is not available; required: "
							.. dependency.version:ToFullString() .. " - available: " .. pl:GetVersion():ToFullString()
		end

		pl:Load()
	end
	return true
end

--- Attempts to resolve and load all soft-dependencies of this plugin.
-- @returns success [boolean] - whether soft-dependencies were resolved successfully
-- @returns reason [string] - the reason it failed, or `nil`
-- @internal
function PLUGIN:ResolveSoftDependencies()
	-- TODO
	return true
end



--- Creates a new plugin by its file path.
-- @param path [string] - the file path
-- @returns plugin [Plugin] - the plugin
-- @internal
function jet.GetPluginByPath(path)
	return setmetatable({
		_path = path
	}, PLUGIN)
end
