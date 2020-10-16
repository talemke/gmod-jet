
--[[
	CLI Plugin -> Help Command (ServerSide)
	by Tassilo (@TASSIA710)

	Soft-Restart the server (changelevel to current map).
--]]

jet.AddCliCommand("restart", function(args)
	RunConsoleCommand("changelevel", game.GetMap())
end, "", "Soft-Restarts the server.")
