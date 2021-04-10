--[[
	CLI Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


-- Load meta tables
include("plugins/cli/meta/sh_jet.lua")


-- Create CLI
Jet._CLI = setmetatable({
	_Commands = {},
	_Register = {}
}, debug.getregistry()["Jet:CLI"])


-- Register commands
include("plugins/cli/commands/sh_version.lua")


-- Attach CLI
Jet:CLI():Attach()
