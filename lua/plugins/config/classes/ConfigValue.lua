--[[
	Config Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Allows for storing configuration variables.
---
--- @class ConfigValue
---
local CLASS = {}
CLASS.__index = CLASS



--- @type string
CLASS._Name = nil

--- @type string
CLASS._Description = nil

--- @type any
CLASS._DefaultValue = nil

--- @type any
CLASS._ActualValue = nil





--- Returns the current value of this [ConfigValue].
---
--- @return any the value
---
function CLASS:GetValue()
	if self._ActualValue ~= nil then
		return self._ActualValue
	end

	if istable(self._DefaultValue) then
		self._ActualValue = table.Copy(self._DefaultValue)
	else
		self._ActualValue = self._DefaultValue
	end
	return self._ActualValue
end


--- Returns the name of this config value.
---
--- @return string the name
---
function CLASS:Name()
	return self._Name
end





-- Register class.
debug.getregistry()["Jet:ConfigValue"] = CLASS

