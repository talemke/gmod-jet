
--[[
	Database Plugin -> Database Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the database class.
--]]

-- Initialize
local DATABASE = {}
DATABASE.__index = DATABASE



-- TODO: Documentation
function DATABASE:Query(sql)
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function DATABASE:Prepare(sql)
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function DATABASE:Escape(str)
	error("No valid database driver loaded.")
end



-- Register
debug.getregistry()["Database"] = DATABASE
