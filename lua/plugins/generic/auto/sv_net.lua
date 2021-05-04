--[[
	Generic Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Networked from the client to signal they are ready to send & receive net messages.
---
--- @direction SV <-- CL
---
util.AddNetworkString("Jet:PlayerNetworkReady")



--- Networked to make a notification pop up on the client.
---
--- @direction SV --> CL
---
util.AddNetworkString("Jet:Notify")



--- Networked to make a client open a URL.
---
--- @direction SV --> CL
---
util.AddNetworkString("Jet:OpenURL")



net.Receive("Jet:PlayerNetworkReady", function(_, ply)
	hook.Run("PlayerNetworkReady", ply)
end)
