
--[[
	Config Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Define variables
config = {}
local globalCache = {}
local pluginCache = {}



-- TODO: Documentation
function config.LoadConfig()
	-- TODO
end

-- TODO: Documentation
function config.SaveConfig()
	-- TODO
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
hook.Run("PluginsLoaded", "PostLoadConfig", function()
	config.SaveConfig()
end)
