
--[[
	String Plugin -> Vector Utility (Shared)
	by Tassilo (@TASSIA710)

	String-Vector utilities.
--]]



--- Generates a vector from a string.
-- @param str [string] - the string
-- @returns vec [Vector] - the generated vector
-- @since v1.0.0
function string.ToVector(str)
	str = string.Explode(";", str)
	if #str ~= 3 then return nil end
	local x = tonumber(str[1])
	local y = tonumber(str[2])
	local z = tonumber(str[3])
	if not x or not y or not z then return nil end
	return Vector(x, y, z)
end



--- Generates a string from a vector.
-- @param vec [Vector] - the vector
-- @returns str [string] - the generated string
-- @since v1.0.0
function string.FromVector(vec)
	return vec.x .. ";" .. vec.y .. ";" .. vec.z
end
