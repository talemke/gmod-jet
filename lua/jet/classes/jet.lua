--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]

--- The global, singleton class for Jet.
---
--- @class Jet
---
local CLASS = {}
CLASS.__index = CLASS



--- The current version of Jet.
---
--- @type Version
---
CLASS.VERSION = nil



--- Creates a new [Version].
---
--- @param major number the major version
--- @param minor number the minor version
--- @param patch number the patch version
--- @param extension string|nil the version extension
--- @return Version the created version
---
function CLASS:CreateVersion(major, minor, patch, extension)
	return setmetatable({
		Major = major,
		Minor = minor,
		Patch = patch,
		Extension = extension
	}, debug.getregistry()["Jet:Version"])
end



-- Register class.
debug.getregistry()["Jet"] = CLASS
