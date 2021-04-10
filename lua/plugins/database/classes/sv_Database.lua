--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class Database
local CLASS = {}
CLASS.__index = CLASS

--- @type DatabaseAdapter
CLASS._Adapter = nil

--- @type table<string, Table>
CLASS._Tables = nil





--- @return DatabaseAdapter
function CLASS:Adapter()
	return self._Adapter
end





--- @param sql string
--- @return PreparedStatement
function CLASS:Prepare(sql)
	return self._Adapter:Prepare(sql)
end





--- @param name string
--- @param sqlName string|nil
--- @return Table
function CLASS:AddTable(name, sqlName)
	sqlName = sqlName or name
	local table = setmetatable({
		_Database = self,
		_LuaName = name,
		_SQLName = sqlName,
		_SQLNameEscaped = "`" .. sqlName .. "`",
		_Columns = {}
	}, debug.getregistry()["Jet:DatabaseTable"])
	self._Tables[name] = table
	return table
end


--- @param name string
--- @return Table|nil
function CLASS:Table(name)
	return self._Tables[name]
end





function CLASS:IsConnected()
	return self._Adapter:IsConnected()
end


function CLASS:Connect()
	self._Adapter:Connect()
end


function CLASS:Disconnect()
	self._Adapter:Disconnect()
end





-- Register class.
debug.getregistry()["Jet:Database"] = CLASS
