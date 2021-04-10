--[[
	CLI Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- The command-line interface base class.
---
--- @class CLI
---
local CLASS = {}
CLASS.__index = CLASS

--- @type CliCommand[]
CLASS._Commands = {}

--- @type table<string, CliCommand>
CLASS._Register = {}





--- Creates (but does not register) a new command.
---
--- @param name string the command name
--- @param description string the description
--- @param aliases string[] the aliases
--- @param realm string the realm (e.g. "SERVER" or "CLIENT")
--- @param callback fun(ply:Player|nil,args:string[],flags:table<string,any>) the callback
--- @return CliCommand the created command
---
function CLASS:CreateCommand(name, description, aliases, realm, callback)
	return setmetatable({
		Name = name,
		Description = description,
		Aliases = aliases,
		Realm = realm,
		Callback = callback
	}, debug.getregistry()["Jet:CLI:Command"])
end





--- Registers the given command.
---
--- @param command CliCommand the command to register
---
function CLASS:RegisterCommand(command)
	table.insert(self._Commands, command)
	self._Register[string.lower(command.Name)] = command
	for _, alias in ipairs(command.Aliases) do
		alias = string.lower(alias)
		if self._Register[alias] == nil then
			self._Register[alias] = command
		end
	end
end





--- Adds a server-side command.
---
--- @param name string the command name
--- @param callback fun(ply:Player|nil,args:string[],flags:table<string,any>) the callback
--- @vararg string aliases
--- @return CliCommand the created command
---
function CLASS:AddServerCommand(name, callback, ...)
	assert(SERVER == true, "Function CLI::AddServerCommand can only be called in server realm.")
	local command = self:CreateCommand(name, "", {...}, "SERVER", callback)
	self:RegisterCommand(command)
	return command
end





--- Adds a server-side, console-only command.
---
--- @param name string the command name
--- @param callback fun(args:string[],flags:table<string,any>) the callback
--- @vararg string aliases
--- @return CliCommand the created command
---
function CLASS:AddConsoleCommand(name, callback, ...)
	assert(SERVER == true, "Function CLI::AddConsoleCommand can only be called in server realm.")
	return self:AddServerCommand(name, function(ply, args, flags)
		if ply == NULL then
			callback(args, flags)
		else
			self:Error("This command can only be invoked from the server console.")
		end
	end, ...)
end





--- Adds a client-side command.
---
--- @param name string the command name
--- @param callback fun(ply:Player,args:string[],flags:table<string,any>) the callback
--- @vararg string aliases
--- @return CliCommand the created command
---
function CLASS:AddClientCommand(name, callback, ...)
	assert(CLIENT == true, "Function CLI::AddClientCommand can only be called in client realm.")
	local command = self:CreateCommand(name, "", {...}, "SERVER", callback)
	self:RegisterCommand(command)
	return command
end





--- Adds a shared command.
---
--- @param name string the command name
--- @param callback fun(ply:Player|nil,args:string[],flags:table<string,any>) the callback
--- @vararg string aliases
--- @return CliCommand the created command
---
function CLASS:AddSharedCommand(name, callback, ...)
	if SERVER == true then
		self:AddServerCommand(name, callback, ...)
	elseif CLIENT == true then
		self:AddClientCommand(name, callback, ...)
	end
end





function CLASS:Info(...)
	Jet:LogInfo("Console", ...)
end

function CLASS:Debug(...)
	Jet:LogDebug("Console", ...)
end

function CLASS:Warn(...)
	Jet:LogWarning("Console", ...)
end

function CLASS:Error(...)
	Jet:LogError("Console", ...)
end

function CLASS:Severe(...)
	Jet:LogSevere("Console", ...)
end





--- Attaches/Loads this CLI.
---
function CLASS:Attach()
	concommand.Add("jet", function(ply, _, args, _)
		if #args == 0 then
			self:Warn("No command supplied. - Type 'help' for a list of available commands.")
			return
		end

		local flags = {}
		local command = args[1]
		table.remove(args, 1)

		local cmd = Jet:CLI()._Register[string.lower(command)]
		if cmd ~= nil then
			cmd.Callback(ply, args, flags)
		else
			self:Warn("Unknown command: '" .. command .. "' - Type 'help' for a list of available commands.")
		end
	end)
end





--- Detaches/Unloads this CLI.
---
function CLASS:Detach()
	concommand.Remove("jet")
end





-- Register class.
debug.getregistry()["Jet:CLI"] = CLASS
