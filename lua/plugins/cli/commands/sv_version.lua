
--[[
	CLI Plugin -> Version Command (ServerSide)
	by Tassilo (@TASSIA710)

	Shows the current version of Jet.
--]]

jet.AddCliCommand("version", function(args)
	print("Running Jet v" .. jet.version:ToFullString())
end, "", "Shows the current version.")
