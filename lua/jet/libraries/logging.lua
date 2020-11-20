
--[[
	Jet -> Logging Library (Shared)
	by Tassilo (@TASSIA710)

	This script adds a nice logging functionality.
--]]

log = {}



local function timestamp()
	local ms = RealTime() % 1
	ms = math.floor(ms * 1000)
	return os.date("!%H:%M:%S") .. "." .. ms
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
-- @since v1.0.0
function log.Info(...)
	if not jet.config.logInfo then return end
	if SERVER and jet.config.logUsingAnsi then print("\27[38;2;255;255;255m" .. varargsToString("  INFO", ...) .. "\27[0m")
	else MsgC(Color(255, 255, 255), varargsToString("  INFO", ...) .. "\n") end
end



--- Logs a message with the `WARN` level.
-- @param msg [varargs] - the message to log
-- @since v1.0.0
function log.Warning(...)
	if not jet.config.logWarning then return end
	if SERVER and jet.config.logUsingAnsi then print("\27[38;2;255;191;0m" .. varargsToString("  WARN", ...) .. "\27[0m")
	else MsgC(Color(255, 191, 0), varargsToString("  WARN", ...) .. "\n") end
end



--- Logs a message with the `ERROR` level.
-- @param msg [varargs] - the message to log
-- @since v1.0.0
function log.Error(...)
	if not jet.config.logError then return end
	if SERVER and jet.config.logUsingAnsi then print("\27[38;2;255;0;0m" .. varargsToString(" ERROR", ...) .. "\27[0m")
	else MsgC(Color(255, 0, 0), varargsToString(" ERROR", ...) .. "\n") end
end



--- Logs a message with the `SEVERE` level.
-- @param msg [varargs] - the message to log
-- @since v1.0.0
function log.Severe(...)
	if SERVER and jet.config.logUsingAnsi then print("\27[101;93m" .. varargsToString("SEVERE", ...) .. "\27[0m")
	else MsgC(Color(255, 0, 0), varargsToString("SEVERE", ...) .. "\n") end
end



--- Logs a message with the `DEBUG` level.
-- @param msg [varargs] - the message to log
-- @since v1.0.0
function log.Debug(...)
	if not jet.config.logDebug then return end
	if SERVER and jet.config.logUsingAnsi then print("\27[38;2;127;127;127m" .. varargsToString(" DEBUG", ...) .. "\27[0m")
	else MsgC(Color(151, 151, 151), varargsToString(" DEBUG", ...) .. "\n") end
end



--- Logs a message with the `NET` level.
-- @param msg [varargs] - the message to log
-- @since v1.0.0
function log.Net(...)
	if not jet.config.logNet then return end
	if SERVER and jet.config.logUsingAnsi then print("\27[38;2;127;127;255m" .. varargsToString("   NET", ...) .. "\27[0m")
	else MsgC(Color(127, 127, 255), varargsToString("   NET", ...) .. "\n") end
end





-- >> ServerLog Override
function ServerLog(msg)
	log.Debug("Server Log: " .. msg)
end
-- >> ServerLog Override





-- >> Error Overrides
local default_error = error
local default_Error = Error
local default_ErrorNoHalt = ErrorNoHalt

function error(msg, error_level)
	log.Severe(msg)
	default_error(msg, error_level)
end

function Error(...)
	log.Error(varargsToString(...))
	default_Error(...)
end

function ErrorNoHalt(...)
	log.Error(varargsToString(...))
	default_ErrorNoHalt(...)
end
-- >> Error Overrides





-- >> Net Overrides
if jet.config.logNet then
	local default_NetStart = net.Start
	local default_NetReceive = net.Receive

	function net.Start(msg, unreliable)
		default_NetStart(msg, unreliable)
		if SERVER then
			log.Net("SV --> CL | " .. msg)
		else
			log.Net("SV <-- CL | " .. msg)
		end
	end

	function net.Receive(msg, callback)
		default_NetReceive(msg, function(len, ply)
			callback(len, ply)
			if SERVER then
				log.Net("SV <-- CL | " .. msg)
			else
				log.Net("SV --> CL | " .. msg)
			end
		end)
	end
end
-- >> Net Overrides
