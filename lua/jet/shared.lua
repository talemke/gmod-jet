
--[[
	Jet -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	This is the initialization script.
--]]


-- Base variable
jet = {}


-- Classes
AddCSLuaFile("classes/plugin.lua")
include("classes/plugin.lua")
AddCSLuaFile("classes/version.lua")
include("classes/version.lua")


-- Version
jet.version = jet.CreateVersion(0, 0, 0, 0, "b0a64a74e51cb54a5369c3e1d5c0295b1931d1b8", "main")


-- Libraries
AddCSLuaFile("libraries/logging.lua")
include("libraries/logging.lua")
AddCSLuaFile("libraries/plugin.lua")
include("libraries/plugin.lua")
AddCSLuaFile("libraries/utility.lua")
include("libraries/utility.lua")


-- Load plugins
jet.LoadPlugins()
