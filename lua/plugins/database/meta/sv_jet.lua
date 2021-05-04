--[[
	Database Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @type Jet
local META = debug.getregistry()["Jet"]

--- @type table<string, Database>
META._Databases = nil





--- @param name string|nil
--- @return Database
function META:Database(name)
	return self._Databases and self._Databases[name]
end





--- Creates a new SQLite database connection.
---
--- @param name string|nil the name for the connection
--- @return Database the database
---
function META:CreateSQLiteDatabase(name)
	local adapter = setmetatable({
		_Internal = db
	}, debug.getregistry()["Jet:DatabaseAdapter:SQLite"])

	local connection = setmetatable({
		_Adapter = adapter,
		_Tables = {}
	}, debug.getregistry()["Jet:Database"])

	self._Databases = self._Databases or {}
	self._Databases[name or "main"] = connection
	return connection
end





--- Creates a new MySQLOO database connection.
---
--- @param hostname string the database server's hostname
--- @param port number the database server's port
--- @param database string the database name
--- @param username string the username
--- @param password string the password
--- @param name string|nil the name for the connection
--- @return Database the database
---
function META:CreateMySQLOODatabase(hostname, port, database, username, password, name)
	local db = mysqloo.connect(hostname, username, password, database, port)

	local adapter = setmetatable({
		_Internal = db
	}, debug.getregistry()["Jet:DatabaseAdapter:MySQLOO"])

	local connection = setmetatable({
		_Adapter = adapter,
		_Tables = {}
	}, debug.getregistry()["Jet:Database"])

	self._Databases = self._Databases or {}
	self._Databases[name or "main"] = connection
	return connection
end
