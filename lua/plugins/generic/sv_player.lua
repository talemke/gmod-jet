
--[[
	Generic Plugin -> Player MetaTable (ServerSide)
	by Tassilo (@TASSIA710)

	Contains all the metafunctions for players.
--]]

local PLAYER = FindMetaTable("Player")



--- Sends a notification to the player.
-- @param text [string] - the message
-- @param class [number] (=NOTIFY_GENERIC) - the notification class
-- @param length [number] (=5) - how long should the notification be shown
-- @realm shared
-- @localonly
-- @since v1.0.0
function PLAYER:Notify(text, class, length)
	net.Start("Jet:Notify")
	net.WriteString(text)
	net.WriteUInt(class, 8)
	net.WriteUInt(length, 8)
	net.Send(self)
end
