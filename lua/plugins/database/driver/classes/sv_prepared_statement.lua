
--[[
	Database Plugin -> MySQLOO Driver -> Prepared Statement Class (ServerSide)
	by Tassilo (@TASSIA710)

	Contains the prepared statement class.
--]]

local STMT = FindMetaTable("PreparedStatement")

function STMT:SetNumber(index, value)
	self._query:setNumber(index, value)
end

function STMT:SetString(index, value)
	self._query:setString(index, value)
end

function STMT:SetBoolean(index, value)
	self._query:setBoolean(index, value)
end

function STMT:SetNull(index)
	self._query:setNull(index)
end

function STMT:Clear()
	self._query:clearParameters()
end
