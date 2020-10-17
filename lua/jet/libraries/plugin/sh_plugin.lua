
--[[
	Jet -> Plugin Library -> Plugin MetaTable (Shared)
	by Tassilo (@TASSIA710)

	This file contains the plugin class.
--]]

local PLUGIN = {}
PLUGIN.__index = PLUGIN
PLUGIN._meta = nil
PLUGIN._path = nil
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
	if not meta.dependencies then
		meta.dependencies = {}
	end
	if not meta.soft_dependencies then
		meta.soft_dependencies = {}
	end

	-- Parse version
	meta.versionData = jet.ParseVersion(meta.version)
	if not meta.versionData then
		return false, "Cannot determine version: " .. meta.version
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
	assert(not self._loaded, "Plugin already loaded.")

	-- PreLoad Hook
	hook.Run("PluginLoad", self)

	-- Prepare
	local pluginPath = "plugins/" .. self._path

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
function PLUGIN:IsDisabled()
	if self._meta and self._meta.disabled then
		return true
	else
		return false
	end
end



--- TODO
-- @internal
function jet.GetPluginByPath(path)
	return setmetatable({
		_path = path
	}, PLUGIN)
end
