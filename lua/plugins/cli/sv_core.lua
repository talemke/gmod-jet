
--[[
	CLI Plugin -> Core (ServerSide)
	by Tassilo (@TASSIA710)

	This script handles exeucting and adding CLI commands.
--]]

local commands = {}
local commandsRegistered = {}

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
-- @since v1.0.0
function jet.AddCliCommand(name, callback, usage, description)
	local cmd = {
		name = name,
		callback = callback,
		usage = usage,
		description = description
	}
	commands[string.lower(name)] = cmd
	table.insert(commandsRegistered, cmd)
end



--- Returns a sequential table of all registered commands.
-- @returns commands [table] - all registered commands
-- @since v1.0.0
function jet.GetCliCommands()
	return commandsRegistered
end
