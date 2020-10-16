
--[[
	CLI Plugin -> Help Command (ServerSide)
	by Tassilo (@TASSIA710)

	This command shows all available commands.
--]]

jet.AddCliCommand("help", function(args)
	print("-------------------")
	print("Available commands:")

	for _, cmd in ipairs(jet.GetCliCommands()) do
		local usage = Either(cmd.usage ~= nil, cmd.usage, "")
		print("jet " .. cmd.name .. " " .. usage .. " | " .. cmd.description)
	end

	print("-------------------")
end, "", "Shows this help.")
