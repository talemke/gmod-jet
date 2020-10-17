
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


-- Utility
AddCSLuaFile("sh_utility.lua")
include("sh_utility.lua")


-- Logging library
AddCSLuaFile("sh_logging.lua")
include("sh_logging.lua")


-- Plugin library
AddCSLuaFile("libraries/plugin/shared.lua")
include("libraries/plugin/shared.lua")


-- Load plugins
jet.LoadPlugins()
