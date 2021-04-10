--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class PreparedStatement
local CLASS = {}
CLASS.__index = CLASS





--- @param index number
--- @param value number|string|boolean|nil
--- @return PreparedStatement
function CLASS:Set(index, value)
	if value == nil then
		return self:SetNull(index)
	elseif isnumber(value) then
		return self:SetNumber(index, value)
	elseif isstring(value) then
		return self:SetString(index, value)
	elseif isbool(value) then
		return self:SetBoolean(index, value)
	else
		Jet:LogSevere("PreparedStatement::Set", "Value ", value, " is of illegal type.")
	end
end





--- @param index number
--- @param value number
--- @return PreparedStatement
function CLASS:SetNumber(index, value)
	-- TODO
	return self
end





--- @param index number
--- @param value string
--- @return PreparedStatement
function CLASS:SetString(index, value)
	-- TODO
	return self
end





--- @param index number
--- @param value boolean
--- @return PreparedStatement
function CLASS:SetBoolean(index, value)
	-- TODO
	return self
end





--- @param index number
--- @return PreparedStatement
function CLASS:SetNull(index)
	-- TODO
	return self
end





--- @param callback fun(err:string|nil,data:table[]|nil)
--- @return PreparedStatement
function CLASS:Submit(callback)
	-- TODO
	return self
end





-- Register class.
debug.getregistry()["Jet:PreparedStatement"] = CLASS
