
--[[
	Jet -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	This is the initialization script.
--]]


-- Base variable
jet = {}
jet.bootTime = RealTime()
jet.continueBooting = true


-- Config
if file.Exists("jet/config.lua", "LUA") then
	AddCSLuaFile("config.lua")
	jet.config = include("config.lua")
else
	AddCSLuaFile("config.example.lua")
	jet.config = include("config.example.lua")
end


-- Classes
AddCSLuaFile("classes/plugin.lua")
include("classes/plugin.lua")
AddCSLuaFile("classes/version.lua")
include("classes/version.lua")


-- Libraries
AddCSLuaFile("libraries/logging.lua")
include("libraries/logging.lua")
AddCSLuaFile("libraries/plugin.lua")
include("libraries/plugin.lua")
AddCSLuaFile("libraries/utility.lua")
include("libraries/utility.lua")
AddCSLuaFile("libraries/version.lua")
include("libraries/version.lua")


-- Load plugins
if jet.continueBooting then
	jet.LoadPlugins()
end
