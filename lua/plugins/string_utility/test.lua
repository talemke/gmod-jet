
--[[
	String Plugin -> Test Suite (Shared)
	by Tassilo (@TASSIA710)
--]]

local iterations = 255 * 255 * 4



-- Test color utilities
log.Debug("[Jet]   - Color Utilities...")
for i = 1, iterations do
	local r = math.random(0, 255)
	local g = math.random(0, 255)
	local b = math.random(0, 255)
	local a = math.random(0, 255)
	local c = Color(r, g, b, a)
	assert(string.ToColor(string.FromColor(c)) == c)
end



-- Test number utilities
log.Debug("[Jet]   - Number Utilities...")
for i = 1, iterations do
	local num = math.random(0, 2^32)
	assert(string.HexToNumber(string.NumberToHex(num)) == num)
end
