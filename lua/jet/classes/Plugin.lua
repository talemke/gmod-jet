--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- The base class for plugins.
---
--- @class Plugin
---
local CLASS = {}
CLASS.__index = CLASS



--- @type PluginInformation
CLASS.PluginInfo = nil



function CLASS:Identifier()
	return self.PluginInfo:Identifier()
end



function CLASS:Info(...)
	Jet:Info(self:Identifier(), "|", ...)
end

function CLASS:Debug(...)
	Jet:Debug(self:Identifier(), "|", ...)
end

function CLASS:Warning(...)
	Jet:Warning(self:Identifier(), "|", ...)
end

function CLASS:Error(...)
	Jet:Error(self:Identifier(), "|", ...)
end

function CLASS:Severe(...)
	Jet:Severe(self:Identifier(), "|", ...)
end



-- Register class.
debug.getregistry()["Jet:Plugin"] = CLASS
