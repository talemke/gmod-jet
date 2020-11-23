
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
		globalCache = data.global or {}
		pluginCache = data.sections or {}
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



-- TODO: Documentation
function config.AddPlugin(plugin, key, default, types, description)
	pluginCache[plugin] = pluginCache[plugin] or {}
	pluginCache[plugin][key] = pluginCache[plugin][key] or default
	-- TODO
end

-- TODO: Documentation
function config.GetPlugin(plugin, key, default)
	pluginCache[plugin] = pluginCache[plugin] or {}
	if pluginCache[plugin][key] ~= nil then
		return pluginCache[plugin][key]
	else
		return default
	end
end

-- TODO: Documentation
function config.SetPlugin(plugin, key, value)
	pluginCache[plugin] = pluginCache[plugin] or {}
	pluginCache[plugin][key] = value
end

-- TODO: Documentation
function config.UnsetPlugin(plugin, key)
	config.SetPlugin(plugin, key, nil)
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
