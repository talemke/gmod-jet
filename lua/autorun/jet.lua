--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]

if SERVER then
	AddCSLuaFile("/jet/client.lua")
	include("/jet/server.lua")
end

if CLIENT then
	include("/jet/client.lua")
end
