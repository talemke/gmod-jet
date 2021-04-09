--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class Database
local CLASS = {}
CLASS.__index = CLASS

--- @type DatabaseAdapter
CLASS._Adapter = nil





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
--- @return Table
function CLASS:Table(name)
	-- TODO
	return nil
end





-- Register class.
debug.getregistry()["Jet:Database"] = CLASS
