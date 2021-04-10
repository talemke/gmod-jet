--[[
	Config Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


--- @type Jet
local META = debug.getregistry()["Jet"]

--- @type Configuration
META._Config = nil



--- Returns the global configuration.
---
--- @return Configuration
---
function META:Config()
	return self._Config
end



--- Creates a new empty configuration.
---
--- @return Configuration
---
function META:NewEmptyConfig()
	return setmetatable({}, debug.getregistry()["Jet:Configuration"])
end
