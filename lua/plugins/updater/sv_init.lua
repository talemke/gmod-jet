
--[[
	Updater Plugin -> Initialize (Shared)
	by Tassilo (@TASSIA710)

	Contains the plugin core.
--]]

jet.updater = {}



--- Fetches a specific release object.
-- @param id [number|string] - the release ID
-- @param callback [function] - the callback function, takes an error message and the release object as arguments
function jet.updater.GetRelease(id, callback)
	if id ~= "latest" then id = "tags/" .. id end
	callback = callback or function() end
	http.Fetch("https://api.github.com/repos/TASSIA710/Jet/releases/" .. id, function(body, _, _, code)
		if code == 200 then
			callback(nil, util.JSONToTable(body))
		elseif code == 404 then
			callback(nil, nil)
		elseif code == 403 then
			callback("Forbidden", nil)
		elseif code == 401 then
			callback("Unauthorized", nil)
		else
			callback("Invalid response: " .. code)
		end
	end, function(message)
		callback(message, nil)
	end, {
		["Accept"] = "application/vnd.github.v3+json"
	})
end



--- Fetches the last release object.
-- @param callback [function] - the callback function, takes an error message and the release object as arguments
function jet.updater.GetLatestRelease(callback)
	jet.updater.GetRelease("latest", callback)
end
