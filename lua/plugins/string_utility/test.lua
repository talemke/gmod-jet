
--[[
	String Plugin -> Test Suite (Shared)
	by Tassilo (@TASSIA710)
--]]



-- Test color utilities
log.Debug("[Jet]   - Color Utilities...")
for i = 1, 255 * 255 do
	local r = math.random(0, 255)
	local g = math.random(0, 255)
	local b = math.random(0, 255)
	local a = math.random(0, 255)
	local c = Color(r, g, b, a)
	assert(string.ToColor(string.FromColor(c)) == c)
end
