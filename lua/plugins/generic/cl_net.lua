
--[[
	Generic Plugin -> Networking Endpoint (ClientSide)
	by Tassilo (@TASSIA710)

	Receive net messages from the server.
--]]



net.Receive("Jet:Notify", function()
	LocalPlayer():Notify(net.ReadString(), net.ReadUInt(8), net.ReadUInt(8))
end)

net.Receive("Jet:OpenURL", function()
	gui.OpenURL(net.ReadString())
end)
