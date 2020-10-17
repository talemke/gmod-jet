
--[[
	Generic Plugin -> Initialize (ServerSide)
	by Tassilo (@TASSIA710)

	Initialize the plugin.
--]]


-- Download files
AddCSLuaFile("sh_constants.lua")
AddCSLuaFile("cl_hooks.lua")
AddCSLuaFile("cl_net.lua")
AddCSLuaFile("cl_player.lua")


-- Include files
include("sh_constants.lua")
include("sv_net.lua")
include("sv_player.lua")
