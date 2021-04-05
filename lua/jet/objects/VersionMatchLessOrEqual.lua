--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @type VersionMatch
local OBJECT = {}
setmetatable(OBJECT, debug.getregistry()["Jet:VersionMatch"])



OBJECT.Matches = function(_, required, provided)
	return provided <= required
end



-- Register object
Jet:SetObject("Jet:VersionMatchLessOrEqual", OBJECT)
