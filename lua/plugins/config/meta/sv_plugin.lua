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
	local config = Jet:Config():Get(self:Identifier())
	if config ~= nil then
		-- TODO: Assert type
		return config:GetValue()
	end

	Jet:Config():Add(self:Identifier(), "Configuration for plugin " .. self.PluginInfo.Name, Jet:NewEmptyConfig())
	return Jet:Config():GetConfig(self:Identifier())
end
