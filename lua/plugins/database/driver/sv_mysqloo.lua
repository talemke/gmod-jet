
--[[
	Database Plugin -> MySQLOO Driver (ServerSide)
	by Tassilo (@TASSIA710)

	Handles the MySQLOO driver.
--]]


-- Require MySQLOO
require("mysqloo")


-- Check for success
if not mysqloo then
	return false, "MySQLOO doesn't seem to be installed."
end


-- Class overrides
include("classes/sv_database.lua")
include("classes/sv_prepared_statement.lua")
include("classes/sv_query.lua")


-- Connect
function db.Connect(hostname, port, database, username, password)
	local con = mysqloo.connect(hostname, username, password, database, port)
	con:connect()
	con:wait()
	return setmetatable({
		_con = con
	}, FindMetaTable("Database"))
end
