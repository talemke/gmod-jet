--[[
	Generic Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



net.Receive("Jet:Notify", function()
	LocalPlayer():Notify(net.ReadString(), net.ReadUInt(8), net.ReadUInt(8))
end)


net.Receive("Jet:OpenURL", function()
	gui.OpenURL(net.ReadString())
end)
