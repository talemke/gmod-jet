
--[[
	Database Plugin -> MySQLOO Driver -> Database Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the database class.
--]]

local DATABASE = FindMetaTable("Database")
DATABASE._con = nil

function DATABASE:Query(sql)
	return setmetatable({
		_query = self._con:query(sql)
	}, FindMetaTable("Query"))
end

function DATABASE:Prepare(sql)
	return setmetatable({
		_query = self._con:prepare(sql)
	}, FindMetaTable("PreparedStatement"))
end

function DATABASE:Escape(str)
	return self._con:escape(str)
end
