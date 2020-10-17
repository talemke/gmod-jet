
--[[
	Generic Plugin -> Networking Endpoint (ServerSide)
	by Tassilo (@TASSIA710)

	Register and receive net messages from clients.
--]]



--- Networked from the client to signal they are ready to send & receive net messages.
-- @direction SV <-- CL
-- @since v1.0.0
util.AddNetworkString("Jet:PlayerNetworkReady")

--- Networked to make a notification pop up on the client.
-- @direction SV --> CL
-- @since v1.0.0
util.AddNetworkString("Jet:Notify")



net.Receive("Jet:PlayerNetworkReady", function(_, ply)
	--- Called when a player is ready to send & receive net messages.
	-- @param ply [Player] - the player
	-- @realm shared
	-- @localonly
	-- @since v1.0.0
	hook.Run("PlayerNetworkReady", ply)
end)
