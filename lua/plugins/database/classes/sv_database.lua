
--[[
	Database Plugin -> Database Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the database class.
--]]

-- Initialize
local DATABASE = {}
DATABASE.__index = DATABASE



--- Creates a new database query.
-- @param sql [string] - the query
-- @returns query [Query] - the created query
function DATABASE:Query(sql)
	error("No valid database driver loaded.")
end



--- Creates a new prepared statement.
-- @param sql [string] - the query
-- @returns statement [PreparedStatement] - the prepared statement
function DATABASE:Prepare(sql)
	error("No valid database driver loaded.")
end



--- Escapes a string to make it safe to use in an SQL query.
-- @note In most cases you should use #Database:Prepare instead.
-- @param str [string] - the string to escape
-- @returns escaped [string] - the escaped string
function DATABASE:Escape(str)
	error("No valid database driver loaded.")
end



--- Checks whether this database object is acutally connected to a database.
-- @returns connected [boolean] - is connected
function DATABASE:IsConnected()
	return false
end



-- Register
debug.getregistry()["Database"] = DATABASE
