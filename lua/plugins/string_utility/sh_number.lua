
--[[
	String Plugin -> Number Utility (Shared)
	by Tassilo (@TASSIA710)

	Number utilities.
--]]



--- Converts a number to a hexadecimal string.
-- @param num [number] - the number
-- @returns hex [string] - the hexadecimal string
-- @since v1.0.0
function string.NumberToHex(num)
	return string.format("%x", num)
end



--- Converts a hexadecimal string to a number.
-- @param hex [string] - the string
-- @returns num [number] - the number
-- @since v1.0.0
function string.HexToNumber(c)
	return tonumber(c, 16)
end
