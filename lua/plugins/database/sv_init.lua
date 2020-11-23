
--[[
	Database Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Configuration
config.AddPlugin("TASSIA710/Database", "Hostname", "localhost", "string", "The hostname of the database.")
config.AddPlugin("TASSIA710/Database", "Port", 3306, "number", "The port of the database.")
config.AddPlugin("TASSIA710/Database", "Database", "database", "string", "The database name.")
config.AddPlugin("TASSIA710/Database", "Username", "username", "string", "The username to use for logging in.")
config.AddPlugin("TASSIA710/Database", "Password", "password", "string", "The password to use for logging in.")


-- Require MySQLOO
require("mysqloo")


-- Check for success
if not mysqloo then
	return false, "MySQLOO doesn't seem to be installed."
end
