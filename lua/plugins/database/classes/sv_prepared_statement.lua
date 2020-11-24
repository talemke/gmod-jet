
--[[
	Database Plugin -> Prepared Statement Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the prepared statement class.
--]]

-- Initialize
local STMT = {}
STMT.__index = FindMetaTable("Query")



--- Specifies the parameter at the given index (starting at 1) using automatic type-detection.
-- @param index [number] - the index
-- @param value [nil|number|string|boolean] - the value
function STMT:Set(index, value)
	if value == nil then
		self:SetNull(index)
	elseif isnumber(value) then
		self:SetNumber(index, value)
	elseif isstring(value) then
		self:SetString(index, value)
	elseif isbool(value) then
		self:SetBoolean(index, value)
	else
		error("Cannot determine data type of value.")
	end
end



--- Specifies a #number parameter at the given index (starting at 1).
-- @param index [number] - the index
-- @param value [number] - the parameter
function STMT:SetNumber(index, value)
	error("No valid database driver loaded.")
end



--- Specifies a #string parameter at the given index (starting at 1).
-- @param index [number] - the index
-- @param value [string] - the parameter
function STMT:SetString(index, value)
	error("No valid database driver loaded.")
end



--- Specifies a #boolean parameter at the given index (starting at 1).
-- @param index [number] - the index
-- @param value [boolean] - the parameter
function STMT:SetBoolean(index, value)
	error("No valid database driver loaded.")
end



--- Specifies a parameter to `nil` at the given index (starting at 1).
-- @param index [number] - the index
function STMT:SetNull(index)
	error("No valid database driver loaded.")
end



--- Clears all previously set parameters.
function STMT:Clear()
	error("No valid database driver loaded.")
end



-- Register
debug.getregistry()["PreparedStatement"] = STMT
