
--[[
	Generic Plugin -> Networking Endpoint (ServerSide)
	by Tassilo (@TASSIA710)

	Register and receive net messages from clients.
--]]



--- Networked from the client to signal they are ready to send & receive net messages.
-- @direction SV <-- CL
util.AddNetworkString("Jet:PlayerNetworkReady")



net.Receive("Jet:PlayerNetworkReady", function(_, ply)
	--- Called when a player is ready to send & receive net messages.
	-- @param ply [Player] - the player
	-- @realm shared
	-- @localonly
	hook.Run("PlayerNetworkReady", ply)
end)
