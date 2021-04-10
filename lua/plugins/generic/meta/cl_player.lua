--[[
	Generic Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


--- @type Player
local META = FindMetaTable("Player")



function META:Notify(text, class, length)
	notification.AddLegacy(text, class or NOTIFY_GENERIC, length or 5)
end



function META:OpenURL(url)
	gui.OpenURL(url)
end
