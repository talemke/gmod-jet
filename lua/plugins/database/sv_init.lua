
--[[
	Database Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Configuration
config.AddPlugin("Tassilo/Database", "Hostname", "localhost", "string", "The hostname of the database.")
config.AddPlugin("Tassilo/Database", "Port", 3306, "number", "The port of the database.")
config.AddPlugin("Tassilo/Database", "Database", "database", "string", "The database name.")
config.AddPlugin("Tassilo/Database", "Username", "username", "string", "The username to use for logging in.")
config.AddPlugin("Tassilo/Database", "Password", "password", "string", "The password to use for logging in.")


-- Require MySQLOO
require("mysqloo")


-- Check for success
if not mysqloo then
	return false, "MySQLOO doesn't seem to be installed."
end
