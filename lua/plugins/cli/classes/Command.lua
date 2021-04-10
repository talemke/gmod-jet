--[[
	CLI Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Defines an abstract command for the CLI.
---
--- @class CliCommand
---
local CLASS = {}
CLASS.__index = CLASS





--- @type string
CLASS.Name = nil

--- @type string
CLASS.Description = nil

--- @type string[]
CLASS.Aliases = nil

--- @type string
CLASS.Realm = nil

--- @type fun(ply:Player|nil,args:string[],flags:table<string,any>)
CLASS.Callback = nil





-- Register class.
debug.getregistry()["Jet:CLI:Command"] = CLASS
