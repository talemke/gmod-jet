
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
	if string.len(str) == 8 then
		local i = string.HexToNumber(str)
		if not i then return nil end
		local r = bit.band(bit.rshift(i, 24), 0xff)
		local g = bit.band(bit.rshift(i, 16), 0xff)
		local b = bit.band(bit.rshift(i, 8), 0xff)
		local a = bit.band(i, 0xff)
		return Color(r, g, b, a)
	elseif string.len(str) == 6 then
		return string.ToColor(str .. "ff")
	else
		return nil
	end
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
	if c.a ~= 255 then
		i = bit.lshift(i, 8)
		i = bit.bor(i, c.a)
	end
	print(i)
	return string.NumberToHex(i)
end
