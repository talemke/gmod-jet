--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Defines whether a given version matches a required version.
---
--- @class VersionMatch
---
local CLASS = {}
CLASS.__index = CLASS



--- Checks if a given version matches against the required version.
---
--- @type fun(self:VersionMatch,required:Version,provided:Version):boolean
---
CLASS.Matches = nil



-- Register class.
debug.getregistry()["Jet:VersionMatch"] = CLASS
