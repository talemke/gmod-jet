
--[[
	Jet -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	This is the initialization script.
--]]


-- Base variable
jet = {}


-- Version
AddCSLuaFile("sh_version.lua")
include("sh_version.lua")


-- Logging library
AddCSLuaFile("sh_logging.lua")
include("sh_logging.lua")


-- Plugin library
AddCSLuaFile("sh_plugin.lua")
include("sh_plugin.lua")


-- Load plugins
jet.LoadPlugins()
