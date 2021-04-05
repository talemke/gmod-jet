--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Defines a dependency for a plugin.
---
--- @class PluginDependency
---
local CLASS = {}
CLASS.__index = CLASS



--- Returns the plugin identifier for the dependency plugin.
---
--- @return string the identifier
---
function CLASS:GetDependencyIdentifier()
	return self.GroupID .. ":" .. self.PluginID
end



--- The group ID of the dependency plugin.
---
--- @type string
---
CLASS.GroupID = nil



--- The plugin ID of the dependency plugin.
---
--- @type string
---
CLASS.PluginID = nil



--- The required version of the dependency plugin.
---
--- @type Version
---
CLASS.Version = nil



--- The version match rule for the dependency plugin.
---
--- @type VersionMatch
---
CLASS.Match = nil





-- Register class.
debug.getregistry()["Jet:PluginDependency"] = CLASS
