
--[[
	Database Plugin -> Prepared Statement Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the prepared statement class.
--]]

-- Initialize
local STMT = {}
STMT.__index = FindMetaTable("Query")



-- TODO: Documentation
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



-- TODO: Documentation
function STMT:SetNumber(index, value)
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function STMT:SetString(index, value)
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function STMT:SetBoolean(index, value)
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function STMT:SetNull(index)
	error("No valid database driver loaded.")
end



--- Clears all previously set parameters.
function STMT:Clear()
	error("No valid database driver loaded.")
end



-- Register
debug.getregistry()["PreparedStatement"] = STMT
