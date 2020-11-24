
--[[
	Database Plugin -> Initialize (ServerSide)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]


-- Configuration
config.AddPlugin("Jet/Database", "Hostname", "localhost", "string", "The hostname of the database.")
config.AddPlugin("Jet/Database", "Port", 3306, "number", "The port of the database.")
config.AddPlugin("Jet/Database", "Database", "database", "string", "The database name.")
config.AddPlugin("Jet/Database", "Username", "username", "string", "The username to use for logging in.")
config.AddPlugin("Jet/Database", "Password", "password", "string", "The password to use for logging in.")


-- Load classes
include("classes/sv_database.lua")
include("classes/sv_query.lua")
include("classes/sv_prepared_statement.lua")


-- Load library
include("sv_library.lua")


-- Load MySQLOO
do
	local status, err = include("driver/sv_mysqloo.lua")
	if status == false then
		return false, err
	end
end


-- Connections
db.SetGlobal(db.Connect(
	config.GetPlugin("Jet/Database", "Hostname"),
	config.GetPlugin("Jet/Database", "Port"),
	config.GetPlugin("Jet/Database", "Database"),
	config.GetPlugin("Jet/Database", "Username"),
	config.GetPlugin("Jet/Database", "Password")
))


-- Connected?
if not db.GetGlobal():IsConnected() then
	return false, "Database connection could not be established."
end
