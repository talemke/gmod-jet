--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @type VersionMatch
local OBJECT = {}
setmetatable(OBJECT, debug.getregistry()["Jet:VersionMatch"])



OBJECT.Matches = function(_, _, _)
	return true
end



-- Register object
Jet:SetObject("Jet:VersionMatchAny", OBJECT)
