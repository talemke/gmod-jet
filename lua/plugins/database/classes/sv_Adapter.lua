--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class DatabaseAdapter
local CLASS = {}
CLASS.__index = CLASS





--- @param sql string
--- @return PreparedStatement
function CLASS:Prepare(sql)
	error("Function DatabaseAdapter::Prepare has not been implemented.")
end


--- @return boolean
function CLASS:IsConnected()
	error("Function DatabaseAdapter::IsConnected has not been implemented.")
end


function CLASS:Disconnect()
	error("Function DatabaseAdapter::Disconnect has not been implemented.")
end





--- @param stmt PreparedStatement
--- @param index number
function CLASS:StatementSetNull(stmt, index)
	error("Function DatabaseAdapter::StatementSetNull has not been implemented.")
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value boolean
function CLASS:StatementSetBoolean(stmt, index, value)
	error("Function DatabaseAdapter::StatementSetBoolean has not been implemented.")
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value number
function CLASS:StatementSetNumber(stmt, index, value)
	error("Function DatabaseAdapter::StatementSetNumber has not been implemented.")
end


--- @param stmt PreparedStatement
--- @param index number
--- @param value string
function CLASS:StatementSetString(stmt, index, value)
	error("Function DatabaseAdapter::StatementSetString has not been implemented.")
end





--- @param stmt PreparedStatement
--- @param callback fun(err:string|nil,data:table[]|nil)
function CLASS:StatementSubmitAsync(stmt, callback)
	error("Function DatabaseAdapter::StatementSubmit has not been implemented.")
end


--- @param stmt PreparedStatement
--- @return string|nil error
--- @return table[]|nil data
function CLASS:StatementSubmitBlocking(stmt)
	error("Function DatabaseAdapter::StatementSubmitBlocking has not been implemented.")
end





-- Register class.
debug.getregistry()["Jet:DatabaseAdapter"] = CLASS
