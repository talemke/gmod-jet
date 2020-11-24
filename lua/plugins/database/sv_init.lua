
--[[
	Database Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Configuration
config.AddPlugin("Jet/Database", "Hostname", "localhost", "string", "The hostname of the database.")
config.AddPlugin("Jet/Database", "Port", 3306, "number", "The port of the database.")
config.AddPlugin("Jet/Database", "Database", "database", "string", "The database name.")
config.AddPlugin("Jet/Database", "Username", "username", "string", "The username to use for logging in.")
config.AddPlugin("Jet/Database", "Password", "password", "string", "The password to use for logging in.")


-- Initialize
db = {}


-- Load MySQLOO
do
	local status, err = include("driver/sv_mysqloo.lua")
	if status == false then
		return false, err
	end
end
