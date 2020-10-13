
--[[
	Jet -> Boot Entry (Shared)
	by Tassilo (@TASSIA710)

	This is the boot entry for Jet.
--]]

if SERVER then
	AddCSLuaFile("jet/cl_init.lua")
	include("jet/sv_init.lua")
else
	include("jet/cl_init.lua")
end
