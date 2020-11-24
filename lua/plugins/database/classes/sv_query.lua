
--[[
	Database Plugin -> Query Class (ServerSide)
	by Tassilo (@TASSIA710)

	Contains the query class.
--]]

-- Initialize
local QUERY = {}
QUERY.__index = QUERY



--- Cancels the query. Only works after #Query:ExecAsync is invoked.
function QUERY:Cancel()
	error("No valid database driver loaded.")
end



--- Executes this query asynchronously.
function QUERY:Exec()
	error("No valid database driver loaded.")
end



--- Executes this query synchronously.
function QUERY:ExecSync()
	error("No valid database driver loaded.")
end



--- Checks whether this query is currently running.
-- @returns running [boolean] - is running
function QUERY:IsRunning()
	error("No valid database driver loaded.")
end



--- Returns the data (a table of rows) of the result of this query.
-- @returns data [table] - the data
function QUERY:GetData()
	error("No valid database driver loaded.")
end



--- Returns the last auto increment index.
-- @returns index [number] - the index
function QUERY:LastInsert()
	error("No valid database driver loaded.")
end



--- Returns how many rows were affected in this query.
-- @returns rows [number] - affected rows
function QUERY:AffectedRows()
	error("No valid database driver loaded.")
end



--- Returns the last error (if any occurred) of this query.
-- @returns error [string] - the error, or `nil`
function QUERY:GetError()
	error("No valid database driver loaded.")
end



--- Called when the query finishes.
-- @param data [table] - the data (table of rows)
function QUERY:OnSuccess(data)
end



--- Called when an error occurs.
-- @param error [string] - the error
-- @param sql [string] - the query
function QUERY:OnError(err, sql)
	log.Error("Error while executing SQL query:")
	log.Error("-> " .. err)
	log.Error("Query: " .. sql)
end



-- Register
debug.getregistry()["Query"] = QUERY
