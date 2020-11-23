
--[[
	Config Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Define variables
config = {}
local globalCache = {}
local pluginCache = {}



-- Define functions
local load = include("sv_func_load.lua")
local save = include("sv_func_save.lua")



-- TODO: Documentation
function config.LoadConfig()
	local data = load()
	if data then
		globalCache = data.global
		pluginCache = data.sections
		return true
	else
		return false
	end
end

-- TODO: Documentation
function config.SaveConfig()
	file.CreateDir("jet")
	return save(globalCache, pluginCache)
end

-- TODO: Documentation
function config.ResetConfig()
	-- TODO
end



-- TODO: Documentation
function config.AddGlobal(key, default, types, description)
	globalCache[key] = globalCache[key] or default
	-- TODO
end

-- TODO: Documentation
function config.GetGlobal(key, default)
	if globalCache[key] ~= nil then
		return globalCache[key]
	else
		return default
	end
end

-- TODO: Documentation
function config.SetGlobal(key, value)
	globalCache[key] = value
end

-- TODO: Documentation
function config.UnsetGlobal(key)
	config.SetGlobal(key, nil)
end



-- Actually load the config
config.LoadConfig()

-- Add missing config options
hook.Add("PluginsLoaded", "PostLoadConfig", function()
	local success = config.SaveConfig()
	if not success then
		log.Error("Failed to save config.")
	end
end)
