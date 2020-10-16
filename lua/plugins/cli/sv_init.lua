
--[[
	CLI Plugin -> Initialize (ServerSide)
	by Tassilo (@TASSIA710)

	This script handles the 'CLI' (command line interface).
--]]

local commands = {}

concommand.Add("jet", function(ply, cmd, args, argsStr)
	local err = "Unknown command. Type 'jet help' for a list of available commands."

	-- Only the console can use this CLI.
	if ply ~= NULL then
		return
	end

	if not args[1] then
		print(err)
		return
	end

	cmd = string.lower(args[1])
	table.remove(args, 1)
	command = commands[cmd]

	if not command then
		print(err)
		return
	end

	local result = command.callback(args)
	if result == false then
		if command.usage then
			print("Correct usage: jet " .. command.name .. " " .. command.usage)
		else
			print("Incorrect usage.")
		end
	end
end)



--- Adds a new CLI command.
-- @param name [string] - the command name
-- @param callback [function] - the callback function, takes a table of arguments as input
-- @param usage [string] (=nil) - how does the command need to be used (e.g. '<player> <reason>' for a kick command)
-- @param description [string] (=nil) - what does this command
-- @param aliases [varargs] - this commands aliases
-- @since v1.0.0
function jet.AddCliCommand(name, callback, usage, description, ...)
	local aliases = {...}

	local cmd = {
		name = name,
		callback = callback,
		usage = usage,
		description = description,
		aliases = aliases
	}

	commands[string.lower(name)] = cmd
	for _, alias in ipairs(aliases) do
		alias = string.lower(name)
		if not commands[alias] then
			commands[alias] = cmd
		end
	end
end



jet.AddCliCommand("help", function(args)
	print("-------------------")
	print("Available commands:")
	for _, cmd in pairs(commands) do
		local usage = Either(cmd.usage ~= nil, cmd.usage, "")
		print("jet " .. cmd.name .. " " .. usage .. " | " .. cmd.description)
	end
	print("-------------------")
end, "", "Shows this help.")

jet.AddCliCommand("test", function(args)
	jet.TestPlugins()
end, "", "Run test suites.")
