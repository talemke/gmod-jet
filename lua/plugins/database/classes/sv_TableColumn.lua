--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @class TableColumn
local CLASS = {}
CLASS.__index = CLASS

--- @type string
CLASS._LuaName = nil

--- @type string
CLASS._SQLName = nil





-- Register class.
debug.getregistry()["Jet:DatabaseTableColumn"] = CLASS
