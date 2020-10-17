
--[[
	CLI Plugin -> Help Command (ServerSide)
	by Tassilo (@TASSIA710)

	This command shows all available commands.
--]]

jet.AddCliCommand("help", function(args)
	-- Analyze first
	local commands = {}
	local maxCommandWidth = 0
	local maxDescriptionWidth = 0

	for _, cmd in ipairs(jet.GetCliCommands()) do
		local command = string.Trim("jet " .. cmd.name .. " " .. (cmd.usage or ""))
		maxCommandWidth = math.max(maxCommandWidth, string.len(command))
		maxDescriptionWidth = math.max(maxDescriptionWidth, string.len(cmd.description))
		table.insert(commands, {
			command, cmd.description
		})
	end

	local maxTotalWidth = maxCommandWidth + maxDescriptionWidth + 3
	local maxDashWidth = math.ceil((maxTotalWidth - 12) / 2)
	local dashes = string.Repeating(maxDashWidth, "-")

	print(dashes .. " Start Help " .. dashes)
	for _, cmd in ipairs(commands) do
		print(cmd[1] .. string.Repeating(maxCommandWidth - string.len(cmd[1]), " ") .. " | " .. cmd[2])
	end
	print(dashes .. "- End Help -" .. dashes)
end, "", "Shows this help.")
