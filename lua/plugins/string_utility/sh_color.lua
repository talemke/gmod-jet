
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
	-- TODO
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
	return string.NumberToHex(i)
end
