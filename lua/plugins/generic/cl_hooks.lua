
--[[
	Generic Plugin -> Hooks (ClientSide)
	by Tassilo (@TASSIA710)

	Register hooks needed for this plugin to work.
--]]



-- We use this for the PlayerNetworkReady hook.
hook.Add("InitPostEntity", "Jet:PlayerNetworkReady", function()
	-- Unregister the hook. This probably isn't need but I like cleaning up.
	hook.Remove("InitPostEntity", "Jet:PlayerNetworkReady")

	-- Replicate to server.
	net.Start("Jet:PlayerNetworkReady")
	net.SendToServer()

	-- Call hook clientside.
	hook.Run("PlayerNetworkReady", LocalPlayer())
end)
