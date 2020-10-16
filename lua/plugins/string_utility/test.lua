
--[[
	String Plugin -> Test Suite (Shared)
	by Tassilo (@TASSIA710)
--]]

local iterations = 255 * 255 * 4


-- Test angle utilities
log.Debug("[Jet]   - Angle Utilities...")
for i = 1, iterations do
	local angle = Angle(math.Rand(0, 2^32), math.Rand(0, 2^32), math.Rand(0, 2^32))
	assert(string.ToAngle(string.FromAngle(angle)) == angle)
end


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


-- Test vector utilities
log.Debug("[Jet]   - Vector Utilities...")
for i = 1, iterations do
	local vector = Vector(math.Rand(0, 2^32), math.Rand(0, 2^32), math.Rand(0, 2^32))
	assert(string.ToVector(string.FromVector(vector)) == vector)
end
