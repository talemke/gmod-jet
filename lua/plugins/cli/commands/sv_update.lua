
--[[
	CLI Plugin -> Update Command (ServerSide)
	by Tassilo (@TASSIA710)

	Check for updates.
--]]

-- This command requires TASSIA710/Updater
if not jet.updater then return end



local function verify(err, data)
	if err then
		log.Error(err)
		return false
	end
	if not data then
		print("Release not found.")
		return false
	end
	return true
end



local function checkForUpdates(err, data)
	if not verify(err, data) then return end
	if "v" .. jet.version:ToString() == data.tag_name then
		print("Installation up to date!")
	else
		print("New version available (" .. data.tag_name .. ")! For more information about the release:")
		print("- 'jet update about " .. data.tag_name .. "'")
	end
end



local function about(err, data)
	if not verify(err, data) then return end
	print("---------- Start Release " .. data.tag_name .. " ----------")
	print("Name: " .. data.name)
	print("Author: " .. data.author.login .. " (" .. data.author.html_url .. ")")
	print("Link: " .. data.html_url)
	print("Notes:\n\n" .. data.body)
	print("----------- End Release " .. data.tag_name .. " -----------")
end



jet.AddCliCommand("update", function(args)
	-- Check for latest release
	if #args == 0 then
		print("Checking for updates...")
		jet.updater.GetLatestRelease(checkForUpdates)
		return
	end

	-- Information about release
	if #args == 2 and string.lower(args[1]) == "about" then
		print("Fetching...")
		jet.updater.GetRelease(args[2], about)
		return
	end

	-- Incorrect usage
	return false
end, "", "Check for updates.")
