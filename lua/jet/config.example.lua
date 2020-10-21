
--[[
	Jet -> Example Configuration File (Shared)
	by Tassilo (@TASSIA710)

	This the example configuration file for Jet.
	Copy (don't move!) the file to 'config.lua'.
--]]

local CONFIG = {}

-- You can use this option to enable/disable Jet.
-- Default: true
CONFIG.enabled = true

-- Determines which plugins should be auto-loaded. Note that this won't prevent available plugins from being loaded
-- if specified as a dependency in one of the auto-loading plugins or its dependencies.
-- Default: true
CONFIG.autoload = true

return CONFIG
