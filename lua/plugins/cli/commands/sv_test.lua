
--[[
	CLI Plugin -> Test Command (ServerSide)
	by Tassilo (@TASSIA710)

	This command can be used to start test suites.
--]]

jet.AddCliCommand("test", function(args)

	-- Correct usage?
	if not args[1] then return false end

	-- Test all?
	if args[1] == "all" or args[1] == "*" then
		jet.TestPlugins()
		return true
	end

	-- Test specific?
	local pl = jet.GetPlugin(args[1])
	if not pl then
		print("Plugin '" .. args[1] .. "' not found.")
		return true
	end
	if not pl:IsTestable() then
		print("Plugin '" .. args[1] .. "' does not supply a test suite.")
		return true
	end

	-- Test
	log.Info("[Jet] Testing plugin...")
	log.Debug("[Jet] - " .. pl:GetIdentifier())
	pl:Test()
	log.Info("[Jet] Done!")
	return true

end, "<plugin/all/*>", "Run test suites.")
