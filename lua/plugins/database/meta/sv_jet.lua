--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @type Jet
local META = debug.getregistry()["Jet"]





--- @param name string|nil
--- @return Database
function META:Database(name)
	-- TODO
	return nil
end





--- Creates a new MySQLOO database connection.
---
--- @param hostname string the database server's hostname
--- @param port number the database server's port
--- @param database string the database name
--- @param username string the username
--- @param password string the password
--- @return Database the database
---
function META:CreateMySQLOODatabase(hostname, port, database, username, password)
	local db = mysqloo.connect(hostname, username, password, database, port)
	local adapter = setmetatable({
		_Internal = db
	}, debug.getregistry()["Jet:DatabaseAdapter:MySQLOO"])
	return setmetatable({
		_Adapter = adapter,
		_Tables = {}
	}, debug.getregistry()["Jet:Database"])
end
