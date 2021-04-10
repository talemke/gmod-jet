--[[
	CLI Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


--- @type Jet
local META = debug.getregistry()["Jet"]

--- @type CLI
META._CLI = nil



--- Returns the CLI for Jet.
---
--- @return CLI the CLI
---
function META:CLI()
	return self._CLI
end
