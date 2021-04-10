--[[
	Generic Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]

print(SERVER)
print(CLIENT)


-- We use this for the PlayerNetworkReady hook.
hook.Add("InitPostEntity", "Jet:Generic:PlayerNetworkReady", function()
	-- Unregister the hook. This probably isn't need but I like cleaning up.
	hook.Remove("InitPostEntity", "Jet:Generic:PlayerNetworkReady")

	-- Replicate to server.
	net.Start("Jet:PlayerNetworkReady")
	net.SendToServer()

	-- Call hook clientside.
	hook.Run("PlayerNetworkReady", LocalPlayer())
end)
