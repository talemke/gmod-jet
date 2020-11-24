
--[[
	CLI Plugin -> Map Command (ServerSide)
	by Tassilo (@TASSIA710)

	Command for quickly changing map.
--]]

jet.AddCliCommand("map", function(args)
	if #args == 0 then
		print("Current Map: " .. game.GetMap())
	elseif #args == 1 then
		RunConsoleCommand("changelevel", args[1])
	else
		return false
	end
end, "", "Change map.")
