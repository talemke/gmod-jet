
--[[
	Database Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Require MySQLOO
require("mysqloo")


-- Check for success
if not mysqloo then
	return false, "MySQLOO doesn't seem to be installed."
end
