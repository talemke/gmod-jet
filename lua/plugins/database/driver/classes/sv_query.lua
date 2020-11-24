
--[[
	Database Plugin -> MySQLOO Driver -> Query Class (Shared)
	by Tassilo (@TASSIA710)

	Contains the query class.
--]]

local QUERY = FindMetaTable("Query")
QUERY._query = nil

function QUERY:ExecAsync()
	self._query.onSuccess = function(data)
		self:OnSuccess(data)
	end
	self._query.onError = function(_, err, sql)
		self:OnError(err, sql)
	end
	self._query:start()
end

function QUERY:ExecSync()
	self:ExecAsync()
	self._query:wait(true)
	local err = self._query:error()
	if err then
		return false, err
	else
		return self._query:getData(), nil
	end
end

function QUERY:Cancel()
	return self._query:abort()
end

function QUERY:IsRunning()
	return self._query:isRunning()
end

function QUERY:GetData()
	return self._query:getData()
end

function QUERY:LastInsert()
	return self._query:lastInsert()
end

function QUERY:AffectedRows()
	return self._query:affectedRows()
end

function QUERY:GetError()
	return self._query:error()
end
