--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



-- Download files
AddCSLuaFile("./classes/jet.lua")
AddCSLuaFile("./classes/version.lua")



-- Include files
include("./classes/jet.lua")
include("./classes/version.lua")



-- Create Jet instance, populate it and push to global.
--- @type Jet
_G.Jet = setmetatable({}, debug.getregistry()["Jet"])

-- Populate Jet instance with version.
Jet.VERSION = Jet:CreateVersion(1, 0, 0, "P1")
