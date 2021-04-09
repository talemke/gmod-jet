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





-- Register class.
debug.getregistry()["Jet:DatabaseAdapter"] = CLASS
