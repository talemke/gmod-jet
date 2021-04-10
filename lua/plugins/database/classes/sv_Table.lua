--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class Table
local CLASS = {}
CLASS.__index = CLASS

--- @type Database
CLASS._Database = nil

--- @type string
CLASS._LuaName = nil

--- @type string
CLASS._SQLName = nil

--- @type string
CLASS._SQLNameEscaped = nil

--- @type TableColumn[]
CLASS._Columns = nil





function CLASS:CreateTable()
	-- TODO
end





--- @return PreparedStatement
function CLASS:DropTableQuery()
	return self._Database:Prepare("DROP TABLE " .. self._SQLNameEscaped .. ";")
end


--- @param callback fun(err:string|nil)
function CLASS:DropTable(callback)
	return self:DropTableQuery():SubmitAsync(callback)
end


--- @return string|nil error
function CLASS:DropTableBlocking()
	return self:DropTableQuery():SubmitBlocking()
end





-- Register class.
debug.getregistry()["Jet:DatabaseTable"] = CLASS
