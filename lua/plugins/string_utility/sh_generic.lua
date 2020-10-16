
--[[
	String Plugin -> Random Strings (Shared)
	by Tassilo (@TASSIA710)

	Generic utilities.
--]]



--- Generates a random string of the specified length using the given chars.
-- @param length [number] - the length
-- @param chars [string] (=0123456789abcdef) - the characters
-- @returns str [string] - the generated string
-- @since v1.0.0
function string.Random(length, chars)
	chars = chars or "0123456789abcdef"
	local str = ""
	for i = 1, length do
		str = str .. chars[math.random(string.len(chars))]
	end
	return str
end



--- Strips the port from a given IP address.
-- @param ip [string] - the IP address
-- @returns str [string] - the modified string
-- @since v1.0.0
function string.StripPort(str)
	return string.Explode(":", str)[1]
end
