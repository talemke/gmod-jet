--[[
	Config Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


-- Load meta tables
include("plugins/config/meta/sh_jet.lua")
include("plugins/config/meta/sh_plugin.lua")


-- Create config
Jet._Config = setmetatable({}, debug.getregistry()["Jet:Configuration"])
Jet._Config:Load("jet/config.json")
