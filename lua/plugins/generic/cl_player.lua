
--[[
	Generic Plugin -> Player MetaTable (ClientSide)
	by Tassilo (@TASSIA710)

	Contains all the metafunctions for players.
--]]

local PLAYER = FindMetaTable("Player")



function PLAYER:Notify(text, class, length)
	notification.AddLegacy(text, class or NOTIFY_GENERIC, length or 5)
end



function PLAYER:OpenURL(url)
	gui.OpenURL(url)
end
