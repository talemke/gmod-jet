--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]

--- Defines a semantic version.
---
--- @class Version
---
local CLASS = {}
CLASS.__index = CLASS



--- The major version. Increment this version when you make incompatible API changes.
---
--- @see [Semantic Versioning](https://semver.org/)
---
--- @type number
---
CLASS.Major = nil



--- The minor version. Increment this version when you add functionality in a backwards compatible manner.
---
--- @see [Semantic Versioning](https://semver.org/)
---
--- @type number
---
CLASS.Minor = nil



--- The patch version. Increment this version when you make backwards compatible bug fixes.
---
--- @see [Semantic Versioning](https://semver.org/)
---
--- @type number
---
CLASS.Patch = nil



--- The extension attached to this version. May contain, for example, a git-ref.
---
--- @see [Semantic Versioning](https://semver.org/)
---
--- @type string|nil
---
CLASS.Extension = nil



--- Generates a string representation for this version.
---
--- @return string a string representation
---
function CLASS:__tostring()
	if self.Extension ~= nil then
		return self.Major .. "." .. self.Minor .. "." .. self.Patch .. "-" .. self.Extension
	else
		return self.Major .. "." .. self.Minor .. "." .. self.Patch
	end
end



--- Overrides less-than-or-equal check behavior.
---
--- @param a Version the first operand
--- @param b Version the second operand
--- @return boolean is less than or equal
---
CLASS.__le = function(a, b)
	-- TODO
end



--- Overrides less-than check behavior.
---
--- @param a Version the first operand
--- @param b Version the second operand
--- @return boolean is less than
---
CLASS.__lt = function(a, b)
	-- TODO
end



--- Overrides equality check behavior.
---
--- @param a Version the first operand
--- @param b Version the second operand
--- @return boolean is equal
---
CLASS.__eq = function(a, b)
	-- Assert that major, minor and patch version match.
	-- The extension is not of any relevance for arithmetic comparisons.
	return a.Major == b.Major and a.Minor == b.Minor and a.Patch == b.Patch
end



-- Register class.
debug.getregistry()["Jet:Version"] = CLASS
