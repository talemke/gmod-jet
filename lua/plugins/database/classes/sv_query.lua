
--[[
	Database Plugin -> Query Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the query class.
--]]

-- Initialize
local QUERY = {}
QUERY.__index = QUERY



-- TODO: Documentation
function QUERY:Cancel()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:ExecAsync()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:ExecSync()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:IsRunning()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:GetData()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:LastInsert()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:AffectedRows()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:GetError()
	error("No valid database driver loaded.")
end



-- TODO: Documentation
function QUERY:OnSuccess(data)
end



-- TODO: Documentation
function QUERY:OnError(err, sql)
end



-- Register
debug.getregistry()["Query"] = QUERY
