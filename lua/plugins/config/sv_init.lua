
--[[
	Config Plugin -> Initialize (ServerSide)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Define variables
config = {}
local globalLayout = {}
local globalCache = {}
local pluginLayout = {}
local pluginCache = {}



-- Define functions
local load = include("sv_func_load.lua")
local save = include("sv_func_save.lua")



-- TODO: Documentation
function config.LoadConfig()
	local data = load()
	if data then
		-- Store
		globalCache = data.global or {}
		pluginCache = data.sections or {}

		-- Fill missing global values
		for key, value in pairs(globalLayout) do
			if not globalCache[key] then
				config.SetGlobal(key, value.default)
			end
		end

		-- Fill missing plugin values
		for plugin, layout in pairs(pluginLayout) do
			for key, value in pairs(layout) do
				if not pluginCache[plugin][key] then
					config.SetPlugin(plugin, key, value.default)
				end
			end
		end
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
	globalLayout[key] = {
		key = key,
		default = default,
		types = Either(isstring(types), {types}, types),
		description = description
	}
	globalCache[key] = globalCache[key] or default
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
	pluginLayout[plugin] = pluginLayout[plugin] or {}
	pluginLayout[plugin][key] = {
		key = key,
		default = default,
		types = Either(isstring(types), {types}, types),
		description = description
	}
	pluginCache[plugin] = pluginCache[plugin] or {}
	pluginCache[plugin][key] = pluginCache[plugin][key] or default
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



-- TODO: Documentation
function config.GetGlobalCache()
	return globalCache
end

-- TODO: Documentation
function config.GetPluginsCache()
	return pluginCache
end



-- Actually load the config
do
	local success = config.LoadConfig()
	if not success then
		log.Error("Failed to load config.")
	end
end

-- Add missing config options
hook.Add("PluginsLoaded", "PostLoadConfig", function()
	local success = config.SaveConfig()
	if not success then
		log.Error("Failed to save config.")
	end
end)
