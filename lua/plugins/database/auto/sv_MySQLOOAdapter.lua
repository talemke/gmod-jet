--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class DatabaseAdapter_MySQLOO : DatabaseAdapter
local CLASS = {}
CLASS.__index = debug.getregistry()["Jet:DatabaseAdapter"]

CLASS._Internal = nil





--- @param str string
--- @return string
function CLASS:Escape(str)
	return self._Internal:escape(str)
end


--- @param sql string
--- @return PreparedStatement
function CLASS:Prepare(sql)
	return setmetatable({
		_SQL = sql,
		_Adapter = self,
		_Internal = self._Internal:prepare(sql)
	}, debug.getregistry()["Jet:PreparedStatement"])
end





--- @return boolean
function CLASS:IsConnected()
	return self._Internal:status() == mysqloo.DATABASE_CONNECTED
end


function CLASS:Connect()
	self._Internal:connect()
	self._Internal:wait()
end


function CLASS:Disconnect()
	self._Internal:disconnect(true)
end





--- @param stmt PreparedStatement
--- @param index number
function CLASS:StatementSetNull(stmt, index)
	stmt._Internal:setNull(index)
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value boolean
function CLASS:StatementSetBoolean(stmt, index, value)
	stmt._Internal:setBoolean(index, value)
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value number
function CLASS:StatementSetNumber(stmt, index, value)
	stmt._Internal:setNumber(index, value)
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value string
function CLASS:StatementSetString(stmt, index, value)
	stmt._Internal:setString(index, value)
end





--- @param stmt PreparedStatement
--- @param callback fun(err:string|nil,data:table[]|nil)
function CLASS:StatementSubmitAsync(stmt, callback)
	stmt._Internal.onError = function(_, err, _)
		callback(err, nil)
	end
	stmt._Internal.onData = function(_, data)
		callback(nil, data)
	end
	stmt._Internal:start()
end


--- @param stmt PreparedStatement
--- @return string|nil error
--- @return table[]|nil data
function CLASS:StatementSubmitBlocking(stmt)
	stmt._Internal:start()
	stmt._Internal:wait(true)
	local err = stmt._Internal:error()
	if err == nil then
		return nil, stmt._Internal:getData()
	else
		return err, nil
	end
end





-- Register class.
debug.getregistry()["Jet:DatabaseAdapter:MySQLOO"] = CLASS
