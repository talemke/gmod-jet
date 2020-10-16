
--[[
	Jet -> Logging (Shared)
	by Tassilo (@TASSIA710)

	This script adds a nice logging functionality.
--]]

log = {}
local useAnsi = false
local logInfo = true
local logWarning = true
local logError = true
local logDebug = true
local logNet = false



local function timestamp()
	return os.date("!%H:%M:%S")
end

local function varargsToString(level, ...)
	local args, str = {...}, ""
	for _, arg in pairs(args) do
		if isentity(arg) then
			if not IsValid(arg) then
				arg = "NULL"
			elseif arg:IsPlayer() then
				arg = arg:SteamNick() .. " (" .. arg:UserID() .. ")"
			else
				arg = arg:GetClass() .. "-" .. arg:EntIndex()
			end
		elseif isvector(arg) then
			arg = arg.x .. ", " .. arg.y .. ", " .. arg.z
		end
		str = str .. " " .. tostring(arg)
	end
	return timestamp() .. " | " .. level .. " | " .. string.sub(str, 2)
end



--- Logs a message with the `INFO` level.
-- @param msg [varargs] - the message to log
function log.Info(...)
	if not logInfo then return end
	if SERVER and useAnsi then print("\27[38;2;255;255;255m" .. varargsToString("  INFO", ...) .. "\27[0m")
	else MsgC(Color(255, 255, 255), varargsToString("  INFO", ...) .. "\n") end
end



--- Logs a message with the `WARN` level.
-- @param msg [varargs] - the message to log
function log.Warning(...)
	if not logWarning then return end
	if SERVER and useAnsi then print("\27[38;2;255;191;0m" .. varargsToString("  WARN", ...) .. "\27[0m")
	else MsgC(Color(255, 191, 0), varargsToString("  WARN", ...) .. "\n") end
end



--- Logs a message with the `ERROR` level.
-- @param msg [varargs] - the message to log
function log.Error(...)
	if not logError then return end
	if SERVER and useAnsi then print("\27[38;2;255;0;0m" .. varargsToString(" ERROR", ...) .. "\27[0m")
	else MsgC(Color(255, 0, 0), varargsToString(" ERROR", ...) .. "\n") end
end



--- Logs a message with the `SEVERE` level.
-- @param msg [varargs] - the message to log
function log.Severe(...)
	if SERVER and useAnsi then print("\27[101;93m" .. varargsToString("SEVERE", ...) .. "\27[0m")
	else MsgC(Color(255, 0, 0), varargsToString("SEVERE", ...) .. "\n") end
end



--- Logs a message with the `DEBUG` level.
-- @param msg [varargs] - the message to log
function log.Debug(...)
	if not logDebug then return end
	if SERVER and useAnsi then print("\27[38;2;127;127;127m" .. varargsToString(" DEBUG", ...) .. "\27[0m")
	else MsgC(Color(151, 151, 151), varargsToString(" DEBUG", ...) .. "\n") end
end



--- Logs a message with the `NET` level.
-- @param msg [varargs] - the message to log
function log.Net(...)
	if not logNet then return end
	if SERVER and useAnsi then print("\27[38;2;127;127;255m" .. varargsToString("   NET", ...) .. "\27[0m")
	else MsgC(Color(127, 127, 255), varargsToString("   NET", ...) .. "\n") end
end





-- >> ServerLog Override
function ServerLog(msg)
	Log.Debug("Server Log: " .. msg)
end
-- >> ServerLog Override





-- >> Error Overrides
local default_error = error
local default_Error = Error
local default_ErrorNoHalt = ErrorNoHalt

function error(msg, error_level)
	Log.Severe(msg)
	default_error(msg, error_level)
end

function Error(...)
	Log.Error(varargsToString(...))
	default_Error(...)
end

function ErrorNoHalt(...)
	Log.Error(varargsToString(...))
	default_ErrorNoHalt(...)
end
-- >> Error Overrides





-- >> Net Overrides
if logNet then
	local default_NetStart = net.Start
	local default_NetReceive = net.Receive

	function net.Start(msg, unreliable)
		default_NetStart(msg, unreliable)
		if SERVER then
			Log.Net("SV --> CL | " .. msg)
		else
			Log.Net("SV <-- CL | " .. msg)
		end
	end

	function net.Receive(msg, callback)
		default_NetReceive(msg, function(len, ply)
			callback(len, ply)
			if SERVER then
				Log.Net("SV <-- CL | " .. msg)
			else
				Log.Net("SV --> CL | " .. msg)
			end
		end)
	end
end
-- >> Net Overrides
