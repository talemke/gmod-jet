--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class DatabaseAdapter
local CLASS = {}
CLASS.__index = CLASS





--- @param sql string
--- @return any
function CLASS:Prepare(sql)
	-- TODO
	return nil
end





-- Register class.
debug.getregistry()["Jet:DatabaseAdapter"] = CLASS
