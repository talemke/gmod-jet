
--[[
	CLI Plugin -> Version Command (ServerSide)
	by Tassilo (@TASSIA710)

	Shows the current version of Jet.
--]]

jet.AddCliCommand("version", function(args)
	local version = string.format("%s | %s @ %s",
					jet.versionFull, jet.versionBranch, jet.versionHeadShort)
	print("Running Jet v" .. version)
end, "", "Shows the current version.")
