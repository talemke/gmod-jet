
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

-- Should messages with the INFO level be logged?
-- Default: true
CONFIG.logInfo = true

-- Should messages with the WARN level be logged?
-- Default: true
CONFIG.logWarning = true

-- Should messages with the ERROR level be logged?
-- Default: true
CONFIG.logError = true

-- Should messages with the DEBUG level be logged?
-- Default: true
CONFIG.logDebug = true

-- Should messages with the NET level be logged?
-- Default: false
CONFIG.logNet = false

-- Should the color formatting be performed using ANSI special characters?
-- In most cases you don't need this, however some server panels, like Pterodactyl, don't natively support
-- colored console output from Garry's Mod. In this case you can enable this option to still have colorful logs!
-- Default: false
CONFIG.logUsingAnsi = false

return CONFIG
