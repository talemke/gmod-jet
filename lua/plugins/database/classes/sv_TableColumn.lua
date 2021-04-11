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

--- @type string
CLASS._SQLType = nil

--- @type boolean
CLASS._SQLNullable = nil

--- @type boolean
CLASS._SQLHasDefault = nil

--- @type nil|boolean|number|string
CLASS._SQLDefault = nil





-- Register class.
debug.getregistry()["Jet:DatabaseTableColumn"] = CLASS
