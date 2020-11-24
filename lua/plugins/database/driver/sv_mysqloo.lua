
--[[
	Database Plugin -> MySQLOO Driver (Shared)
	by Tassilo (@TASSIA710)

	Handles the MySQLOO driver.
--]]

local default = nil


-- Require MySQLOO
require("mysqloo")


-- Connections
default = mysqloo.connect(
    config.GetPlugin("Jet/Database", "Hostname"),
    config.GetPlugin("Jet/Database", "Username"),
    config.GetPlugin("Jet/Database", "Password"),
    config.GetPlugin("Jet/Database", "Database"),
    config.GetPlugin("Jet/Database", "Port")
)


-- Check for success
if not mysqloo then
	return false, "MySQLOO doesn't seem to be installed."
end
