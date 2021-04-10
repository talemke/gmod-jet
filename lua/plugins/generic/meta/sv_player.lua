--[[
	Generic Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


--- @type Player
local META = FindMetaTable("Player")



--- Sends a notification to the player.
---
--- @param text string the message
--- @param class number|nil the notification class
--- @param length number|nil how long the notification should be shown (in seconds)
---
function META:Notify(text, class, length)
	net.Start("Jet:Notify")
	net.WriteString(text)
	net.WriteUInt(class or NOTIFY_GENERIC, 8)
	net.WriteUInt(length or 5, 8)
	net.Send(self)
end



--- Makes the player open a URL.
---
--- @param url string the URL to open
---
function META:OpenURL(url)
	net.Start("Jet:OpenURL")
	net.WriteString(url)
	net.Send(self)
end
