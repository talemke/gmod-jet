--[[
	Config Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Allows for storing configuration variables.
---
--- @class Configuration
---
local CLASS = {}
CLASS.__index = CLASS

--- @type table<string, ConfigValue>
CLASS._Store = {}





--- @param path string
--- @param description string
--- @param default string|number|boolean|Configuration
--- @return ConfigValue
function CLASS:Add(path, description, default)
	local config = setmetatable({
		_Name = path,
		_Description = description,
		_DefaultValue = default,
		_ActualValue = nil
	}, debug.getregistry()["Jet:ConfigValue"])
	self._Store[path] = config
	return config
end





--- @param path string
--- @return ConfigValue|nil
function CLASS:Get(path)
	return self._Store[path]
end


--- @param path string
--- @param value any
function CLASS:Set(path, value)
	local config = self:Get(path)
	assert(config ~= nil, "Config '" .. path.. "' has not been added.")
	config._ActualValue = value
end


--- @param path string
--- @return boolean
function CLASS:GetBoolean(path)
	local config = self:Get(path)
	if config == nil then return nil end
	local value = config:GetValue()
	assert(isbool(value), "Config '" .. config:Name() .. "' is not of type boolean.")
	return value
end


--- @param path string
--- @return number
function CLASS:GetNumber(path)
	local config = self:Get(path)
	if config == nil then return nil end
	local value = config:GetValue()
	assert(isnumber(value), "Config '" .. config:Name() .. "' is not of type number.")
	return value
end


--- @param path string
--- @return string
function CLASS:GetString(path)
	local config = self:Get(path)
	if config == nil then return nil end
	local value = config:GetValue()
	assert(isstring(value), "Config '" .. config:Name() .. "' is not of type string.")
	return value
end


--- @param path string
--- @return Configuration
function CLASS:GetConfig(path)
	local config = self:Get(path)
	if config == nil then return nil end
	local value = config:GetValue()
	-- TODO: Assert type
	return value
end





--- Saves this config to the given destination file.
---
--- @param destFile string the destination file
---
function CLASS:Save(destFile)
	local json = util.TableToJSON(self._Store)
	file.Write(destFile, json)
end


--- Loads this config from the given source file.
---
--- @param sourceFile string the source file
---
function CLASS:Load(sourceFile)
	if not file.Exists(sourceFile, "DATA") then return end
	local json = file.Read(sourceFile, "DATA")
	self._Store = util.JSONToTable(json)
end





-- Register class.
debug.getregistry()["Jet:Configuration"] = CLASS

