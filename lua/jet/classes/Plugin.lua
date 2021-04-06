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
	Jet:Log(self:Identifier(), " INFO", ...)
end

function CLASS:Debug(...)
	Jet:Log(self:Identifier(), "DEBUG", ...)
end

function CLASS:Warning(...)
	Jet:Log(self:Identifier(), " WARN", ...)
end

function CLASS:Error(...)
	Jet:Log(self:Identifier(), "ERROR", ...)
end

function CLASS:Severe(...)
	Jet:Log(self:Identifier(), "SEVERE", ...)
end



-- Register class.
debug.getregistry()["Jet:Plugin"] = CLASS
