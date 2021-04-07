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
	Jet:LogInfo(self:Identifier(), ...)
end

function CLASS:Debug(...)
	Jet:LogDebug(self:Identifier(), ...)
end

function CLASS:Warn(...)
	Jet:LogWarning(self:Identifier(), ...)
end

function CLASS:Error(...)
	Jet:LogError(self:Identifier(), ...)
end

function CLASS:Severe(...)
	Jet:LogSevere(self:Identifier(), ...)
end



-- Register class.
debug.getregistry()["Jet:Plugin"] = CLASS
