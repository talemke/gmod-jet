--[[
	Jet -> Bootstrapper
	by Tassilo Lemke
--]]

if SERVER then
	include("jet/sh_init.lua")
	include("jet/sv_init.lua")
end

if CLIENT then
	include("jet/sh_init.lua")
	include("jet/cl_init.lua")
end

if SERVER then
	AddCSLuaFile("jet/cl_init.lua")
	AddCSLuaFile("jet/sh_init.lua")
end
