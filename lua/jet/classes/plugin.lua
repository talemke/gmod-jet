
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





--- TODO
-- @internal
function PLUGIN:Init()
	-- Assert
	assert(self._path ~= nil, "Path not specified.")
	assert(self._meta == nil, "Plugin already initialized.")

	-- PreInitialize Hook
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
	AddCSLuaFileSafe(pluginPath .. "/cl_init.lua")
	AddCSLuaFileSafe(pluginPath .. "/sh_test.lua")
	AddCSLuaFileSafe(pluginPath .. "/cl_test.lua")
	AddCSLuaFileSafe(pluginPath .. "/sh_unload.lua")
	AddCSLuaFileSafe(pluginPath .. "/cl_unload.lua")

	-- Store
	self._meta = meta

	-- PostInitialize Hook
	hook.Run("PluginInitialized", self)
	return true
end





--- TODO
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
	hook.Run("PluginLoaded", self)
end





--- TODO
function PLUGIN:Unload()
	-- Assert
	assert(self._meta ~= nil, "Plugin not initialized.")
	assert(self._path ~= nil, "Plugin not initialized.")
	assert(self._loaded, "Plugin not loaded.")

	-- PreUnload Hook
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
	hook.Run("PluginUnloaded", self)
end





--- TODO
function PLUGIN:IsLoaded()
	return self._loaded
end



--- TODO
function PLUGIN:GetPathName()
	return self._path
end



--- TODO
function PLUGIN:GetIdentifier()
	return self._meta.author .. "/" .. self._meta.name
end



--- TODO
function PLUGIN:GetDependencies()
	return self._dependencies
end



--- TODO
function PLUGIN:GetSoftDependencies()
	return self._dependenciesSoft
end



--- TODO
function PLUGIN:GetVersion()
	return self._version
end



--- TODO
function PLUGIN:IsDisabled()
	if self._meta and self._meta.disabled then
		return true
	else
		return false
	end
end



--- TODO
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



--- TODO
function PLUGIN:ResolveSoftDependencies()
	-- TODO
	return true
end



--- TODO
-- @internal
function jet.GetPluginByPath(path)
	return setmetatable({
		_path = path
	}, PLUGIN)
end
