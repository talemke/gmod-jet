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





--- Adds a client-side command.
---
--- @param name string the command name
--- @param callback fun(ply:Player|nil,args:string[],flags:table<string,any>) the callback
--- @vararg string aliases
--- @return CliCommand the created command
---
function CLASS:AddClientCommand(name, callback, ...)
	assert(CLIENT == true, "Function CLI::AddClientCommand can only be called in client realm.")
	local command = self:CreateCommand(name, "", {...}, "SERVER", callback)
	self:RegisterCommand(command)
	return command
end





-- Register class.
debug.getregistry()["Jet:CLI"] = CLASS
