
--[[
	String Plugin -> Angle Utility (Shared)
	by Tassilo (@TASSIA710)

	String-Angle utilities.
--]]



--- Generates an angle from a string.
-- @param str [string] - the string
-- @returns ang [Angle] - the generated angle
function string.ToAngle(str)
	str = string.Explode(";", str)
	if #str ~= 3 then return nil end
	local x = tonumber(str[1])
	local y = tonumber(str[2])
	local z = tonumber(str[3])
	if not x or not y or not z then return nil end
	return Angle(x, y, z)
end



--- Generates a string from an angle.
-- @param ang [Angle] - the angle
-- @returns str [string] - the generated string
function string.FromAngle(ang)
	return ang.x .. ";" .. ang.y .. ";" .. ang.z
end
