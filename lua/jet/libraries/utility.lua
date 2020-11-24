
--[[
	Jet -> Utility Library (Shared)
	by Tassilo (@TASSIA710)

	This file contains all the utility required by the plugins system.
--]]



--- Parses a dependency string.
-- @param str [string] - the dependency string
-- @returns dependency [table] - dependency data, or `nil`
-- @since v1.0.0
function jet.ParseDependency(str)
	str = string.Explode("/", str)
	if #str ~= 2 then return nil end
	local author = str[1]
	local name = string.Explode("@", str[2])
	if #name ~= 2 then return nil end
	local version = jet.ParseVersion(name[2])
	if not version then return nil end
	return {
		author = author,
		name = name[1],
		identifier = author .. "/" .. name[1],
		version = version
	}
end



--- Behaves the same as #AddCSLuaFile. The only difference is, this doesn't
-- throw any errors if the specified file doesn't exist.
-- @param filePath [string] (="current file") - the file name
-- @since v1.0.0
function AddCSLuaFileSafe(filePath)
	if not SERVER then return end
	if file.Exists(filePath, "LUA") then
		AddCSLuaFile(filePath)
	end
end



--- Behaves the same as #include. The only difference is, this doesn't throw
-- any errors if the specified file doesn't exist.
-- @param file [string] - the file name
-- @since v1.0.0
function IncludeSafe(filePath)
	if not filePath then return end
	if file.Exists(filePath, "LUA") then
		return include(filePath)
	end
end
