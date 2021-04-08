--[[
	Config Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]


--- @type Plugin
local META = debug.getregistry()["Jet:Plugin"]



--- Returns the configuration for this plugin.
---
--- @return Configuration
---
function META:Config()
	return Jet:Config():GetConfig(self:Identifier())
end
