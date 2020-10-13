
--[[
	Jet -> Initialize (ClientSide)
	by Tassilo (@TASSIA710)

	This is the server initialization script.
--]]


-- Base variable
jet = {}


-- Logging library
include("sh_logging.lua")


-- Plugin library
include("sh_plugin.lua")


-- Load plugins
jet.LoadPlugins()
