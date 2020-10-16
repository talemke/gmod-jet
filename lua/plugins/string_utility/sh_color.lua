
--[[
	String Plugin -> Random Strings (Shared)
	by Tassilo (@TASSIA710)

	String-Color utilities.
--]]



--- Generates a color from a string.
-- @param str [string] - the string
-- @returns c [Color] - the generated color
-- @since v1.0.0
function string.ToColor(str)
	local i = string.HexToNumber(str)
	if not i then return nil end
	local r = bit.band(bit.rshift(i, 24), 0xff)
	local g = bit.band(bit.rshift(i, 16), 0xff)
	local b = bit.band(bit.rshift(i, 8), 0xff)
	local a = bit.band(i, 0xff)
	return Color(r, g, b, a)
end



--- Generates a string from a color.
-- @param c [Color] - the color
-- @returns str [string] - the generated string
-- @since v1.0.0
function string.FromColor(c)
	local i = c.r
	i = bit.lshift(i, 8)
	i = bit.bor(i, c.g)
	i = bit.lshift(i, 8)
	i = bit.bor(i, c.b)
	i = bit.lshift(i, 8)
	i = bit.bor(i, c.a)
	return string.NumberToHex(i)
end
