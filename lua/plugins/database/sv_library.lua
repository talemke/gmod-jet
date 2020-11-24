
--[[
	Database Plugin -> Library (Shared)
	by Tassilo (@TASSIA710)

	Contains all the library functions.
--]]


-- Initialize
local connections = {}
db = {}



-- TODO: Documentation
function db.GetConnection(name)
    return connections[name]
end



-- TODO: Documentation
function db.SetConnection(name, connection)
    connections[name] = connection
end



-- TODO: Documentation
function db.GetGlobal()
    return db.GetConnection("global")
end



-- TODO: Documentation
function db.SetGlobal(connection)
    db.SetConnection("global", connection)
end



-- TODO: Documentation
function db.Connect(hostname, port, database, username, password)
	error("No valid database driver loaded.")
end
