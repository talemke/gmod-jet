--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



-- Download classes
AddCSLuaFile("./classes/Jet.lua")
AddCSLuaFile("./classes/Plugin.lua")
AddCSLuaFile("./classes/PluginInformation.lua")
AddCSLuaFile("./classes/PluginManager.lua")
AddCSLuaFile("./classes/Version.lua")
AddCSLuaFile("./classes/VersionMatch.lua")

-- Download libraries
AddCSLuaFile("./libraries/file.lua")
AddCSLuaFile("./libraries/global.lua")

-- Download objects
AddCSLuaFile("./objects/VersionMatchAny.lua")
AddCSLuaFile("./objects/VersionMatchExactly.lua")
AddCSLuaFile("./objects/VersionMatchGreaterOrEqual.lua")
AddCSLuaFile("./objects/VersionMatchGreaterThan.lua")
AddCSLuaFile("./objects/VersionMatchLessOrEqual.lua")
AddCSLuaFile("./objects/VersionMatchLessThan.lua")



-- Include classes
include("./classes/Jet.lua")
include("./classes/Plugin.lua")
include("./classes/PluginInformation.lua")
include("./classes/PluginManager.lua")
include("./classes/Version.lua")
include("./classes/VersionMatch.lua")

-- Include libraries
include("./libraries/file.lua")
include("./libraries/global.lua")

-- Include objects
include("./objects/VersionMatchAny.lua")
include("./objects/VersionMatchExactly.lua")
include("./objects/VersionMatchGreaterOrEqual.lua")
include("./objects/VersionMatchGreaterThan.lua")
include("./objects/VersionMatchLessOrEqual.lua")
include("./objects/VersionMatchLessThan.lua")



-- Create Jet instance, populate it and push to global.
--- @type Jet
_G.Jet = setmetatable({}, debug.getregistry()["Jet"])

-- Populate Jet instance
Jet.VERSION = Jet:CreateVersion(1, 0, 0, "P1")
Jet._Objects = {}
Jet._Plugins = setmetatable({}, debug.getregistry()["Jet:PluginManager"])



-- Locate plugins
Jet:Plugins():LocatePlugins()
