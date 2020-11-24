
--[[
	Database Plugin -> Library (ServerSide)
	by Tassilo (@TASSIA710)

	Contains all the library functions.
--]]


-- Initialize
local connections = {}
db = {}



--- Returns a connection by its name (e.g. 'global' or 'beta') or `nil` if no such connection exists.
-- @param name [string] - the name
-- @returns connection [Database] - the database connection
function db.GetConnection(name)
    return connections[name]
end



--- Registers a connection and links it to a name (e.g. 'global' or 'beta').
-- @param name [string] - the name
-- @param connection [Database] - the database connection
function db.SetConnection(name, connection)
    connections[name] = connection
end



--- Returns the global database. This database can (and should) be used by all plugins.
-- This function is the same as running:
-- ```lua
-- db.GetConnection("global")
-- ```
-- @returns connection [Database] - the global database connection
function db.GetGlobal()
    return db.GetConnection("global")
end



--- Sets the global database. This function is the same as running:
-- ```lua
-- db.SetConnection("global", connection)
-- ```
-- @param connection [Database] - the global database connection
-- @internal
function db.SetGlobal(connection)
    db.SetConnection("global", connection)
end



--- Creates a new database connection.
-- @param hostname [string] - the hostname
-- @param port [number] - the port
-- @param database [string] - the database
-- @param username [string] - the username
-- @param password [string] - the password
function db.Connect(hostname, port, database, username, password)
	error("No valid database driver loaded.")
end
