
--[[
	Jet -> Plugin Loader (Shared)
	by Tassilo (@TASSIA710)

	This script handles all the plugin stuff, such as loading.
--]]

local plugins = {}



--- Parses version data from a version string.
-- @param str [string] - the version string (e.g. '1.0.0')
-- @returns version [table] - the version data, or `nil`
function jet.ParseVersion(str)
	local parsed = {string.match(str, "([%d])%.([%d])%.([%d])")}
	if not parsed[1] and not parsed[2] and not parsed[3] then
		return nil
	else
		return parsed
	end
end



--- Loads a plugin by its folder name.
-- @param name [string] - the folder name
-- @returns success [boolean] - whether the plugin was loaded successfully
-- @returns error [string|table] - the reason the loading failed, or the plugin information on success
function jet.LoadPlugin(name)
	-- Plugin already loaded?
	if plugins[name] then return not plugins[name].disabled end

	-- Define paths
	local pathPlugins = "plugins"
	local pathPlugin = pathPlugins .. "/" .. name
	local metaFile = pathPlugin .. "/plugin.lua"

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

	-- Load dependencies first
	for _, dependency in pairs(meta.dependencies) do
		if not jet.LoadPlugin(dependency) then
			return false, "Dependency " .. dependency .. " not available."
		end
	end

	-- Load shared.lua
	if file.Exists(pathPlugin .. "/shared.lua", "LUA") then
		AddCSLuaFile(pathPlugin .. "/shared.lua")
		include(pathPlugin .. "/shared.lua")
	end

	-- Load sv_init.lua
	if file.Exists(pathPlugin .. "/sv_init.lua", "LUA") and SERVER then
		include(pathPlugin .. "/sv_init.lua")
	end

	-- Load cl_init.lua
	if file.Exists(pathPlugin .. "/cl_init.lua", "LUA") then
		if SERVER then
			AddCSLuaFile(pathPlugin .. "/cl_init.lua")
		else
			include(pathPlugin .. "/cl_init.lua")
		end
	end

	-- Load entities
	-- TODO

	-- Load weapons
	-- TODO

	-- Done!
	return true, meta
end



--- Loads all available plugins in the plugins directory.
-- @returns count [number] - how many plugin folders were detected
-- @returns success [number] - how many plugins were loaded successfully
function jet.LoadPlugins()
	log.Info("[Jet] Loading plugins...")
	local count, success = 0, 0
	local _, dirs = file.Find("plugins/*", "LUA")

	for _, dir in pairs(dirs) do
		status, data = jet.LoadPlugin(dir)
		if status then
			log.Debug("[Jet] - " .. data.author .. "/" .. data.name .. " - v" .. data.version)
			success = success + 1
		else
			log.Warning("[Jet] Failed to load plugin '" .. dir .. "': " .. data)
		end
		count = count + 1
	end

	if count == success then
		log.Info("[Jet] Loaded all " .. count .. " plugins.")
	else
		log.Info("[Jet] Loaded " .. success .. " out of " .. count .. " available plugins.")
	end
	return count, success
end
