--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class DatabaseAdapter_SQLite : DatabaseAdapter
local CLASS = {}
CLASS.__index = debug.getregistry()["Jet:DatabaseAdapter"]





--- @param str string
--- @return string
function CLASS:Escape(str)
	return sql.SQLStr(str, false)
end


--- @param sql string
--- @return PreparedStatement
function CLASS:Prepare(sql)
	return setmetatable({
		_SQL = sql,
		_Adapter = self,
		_Parameters = {}
	}, debug.getregistry()["Jet:PreparedStatement"])
end





--- @return boolean
function CLASS:IsConnected()
	return true
end


function CLASS:Connect()
	-- Do nothing
end


function CLASS:Disconnect()
	-- Do nothing
end





--- @param stmt PreparedStatement
--- @param index number
function CLASS:StatementSetNull(stmt, index)
	stmt._Parameters[index] = nil
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value boolean
function CLASS:StatementSetBoolean(stmt, index, value)
	stmt._Parameters[index] = value
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value number
function CLASS:StatementSetNumber(stmt, index, value)
	stmt._Parameters[index] = value
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value string
function CLASS:StatementSetString(stmt, index, value)
	stmt._Parameters[index] = value
end





--- @param stmt PreparedStatement
--- @param callback fun(err:string|nil,data:table[]|nil)
function CLASS:StatementSubmitAsync(stmt, callback)
	callback(self:StatementSubmitBlocking(stmt))
end


--- @param stmt PreparedStatement
--- @return string|nil error
--- @return table[]|nil data
function CLASS:StatementSubmitBlocking(stmt)
	error("Function DatabaseAdapter::StatementSubmitBlocking has not been implemented.")
end





-- Register class.
debug.getregistry()["Jet:DatabaseAdapter:SQLite"] = CLASS
