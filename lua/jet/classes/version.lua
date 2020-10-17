
--[[
	Jet -> Version Class (Shared)
	by Tassilo (@TASSIA710)

	This file contains the version class.
--]]

local VERSION = {}
VERSION.__index = VERSION

VERSION._major = 0
VERSION._minor = 0
VERSION._patch = 0
VERSION._build = 0
VERSION._head = ""
VERSION._branch = ""

AccessorFunc(VERSION, "_major", "Major", FORCE_NUMBER)
AccessorFunc(VERSION, "_minor", "Minor", FORCE_NUMBER)
AccessorFunc(VERSION, "_patch", "Patch", FORCE_NUMBER)
AccessorFunc(VERSION, "_build", "Build", FORCE_NUMBER)
AccessorFunc(VERSION, "_branch", "Branch", FORCE_STRING)
AccessorFunc(VERSION, "_head", "Head", FORCE_STRING)



--- Gets the short head of this version (usually the first 7 characters).
-- @returns head [string] - the short head
function VERSION:GetShortHead()
	return string.sub(self:GetHead(), 0, 7)
end

--- Returns the small version string (e.g. '1.3')
-- @returns str [string] - the small version string
function VERSION:ToSmallString()
	return self._major .. "." .. self._minor
end

--- Returns the version as a string (e.g. '1.3.2')
-- @returns str [string] - the version string
function VERSION:ToString()
	return self:ToSmallString() .. "." .. self._patch
end

--- Returns the full version string (e.g. '1.3.2, build 71')
-- @returns str [string] - the full version string
function VERSION:ToFullString()
	return self:ToString() .. ", build " .. self._build
end

--- Checks whether this current version does support the required target version.
-- @param target [Version] - the version to check against
-- @returns compatible [boolean] - is compatible?
function VERSION:IsCompatible(target)
	-- This looks very confusing and needs to be cleaned up (TODO).
	if self._major ~= target._major then return false end
	if target._minor == -1 then return true end
	if self._minor < target._minor then return false end
	if target._patch == -1 then return true end
	return self._patch >= target._patch
end

--- Creates a new version object.
-- @param major [number] - the major version
-- @param minor [number] (=-1) - the minor version
-- @param patch [number] (=-1) - the patch version
-- @param head [string] (=-1) - the git head (must be the full head)
-- @param branch [string] (="") - the git branch
-- @returns version [Version] (="") - the created version
function jet.CreateVersion(major, minor, patch, build, head, branch)
	-- Asserts
	assert(major ~= nil and isnumber(major))
	assert(minor == nil or isnumber(minor))
	assert(patch == nil or isnumber(patch))
	assert(build == nil or isnumber(build))
	assert(head == nil or isstring(head))
	assert(branch == nil or isstring(branch))

	-- Create
	return setmetatable({
		_major = major,
		_minor = minor or -1,
		_patch = patch or -1,
		_build = build or -1,
		_head = head or "",
		_branch = branch or ""
	}, VERSION)
end

--- Parses version data from a version string.
-- @param str [string] - the version string (e.g. '1.0.0')
-- @returns version [Version] - the version, or `nil`
function jet.ParseVersion(str)
	if str[1] == "v" then str = string.sub(str, 2) end
	local parsed = {string.match(str, "([%d])%.([%d])%.([%d])")}
	if not parsed[1] and not parsed[2] and not parsed[3] then
		return nil
	else
		parsed[1] = tonumber(parsed[1])
		parsed[2] = tonumber(parsed[2])
		parsed[3] = tonumber(parsed[3])
		return jet.CreateVersion(parsed[1], parsed[2], parsed[3])
	end
end
