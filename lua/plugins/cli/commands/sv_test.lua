
--[[
	CLI Plugin -> Test Command (ServerSide)
	by Tassilo (@TASSIA710)

	This command can be used to start test suites.
--]]

jet.AddCliCommand("test", function(args)
	jet.TestPlugins()
end, "", "Run test suites.")
