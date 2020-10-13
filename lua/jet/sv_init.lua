
--[[
	Jet -> Initialize (ServerSide)
	by Tassilo (@TASSIA710)

	This is the server initialization script.
--]]


-- Base variable
jet = {}


-- Logging library
AddCSLuaFile("sh_logging.lua")
include("sh_logging.lua")


-- Plugin library
AddCSLuaFile("sh_plugin.lua")
include("sh_plugin.lua")


-- Load plugins
jet.LoadPlugins()
