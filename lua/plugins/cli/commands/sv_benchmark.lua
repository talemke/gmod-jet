
--[[
	CLI Plugin -> Help Command (ServerSide)
	by Tassilo (@TASSIA710)

	This command adds a quick benckmarking utility.
--]]

local function formatTime(time)
	if time > 1 then
		return math.Round(time, 4) .. " s"
	elseif time > 0.001 then
		time = time * 1000
		return math.Round(time, 4) .. " ms"
	elseif time > 0.000001 then
		time = time * 1000000
		return math.Round(time, 4) .. " μs"
	elseif time > 0.000000001 then
		time = time * 1000000000
		return math.Round(time, 4) .. " ns"
	elseif time > 0.000000000001 then
		time = time * 1000000000000
		return time .. " ps"
	else
		return time .. " s"
	end
end

jet.AddCliCommand("benchmark", function(args)
	if #args < 2 then return false end

	local iterations = tonumber(args[1])
	if not iterations then return false end

	print("Compiling expression...")
	local exp = CompileString(table.concat(args, " ", 2), "Benchmarker", false)
	if isstring(exp) then
		print("Failed: " .. exp)
		return
	end
	if not isfunction(exp) then
		print("Failed: Unknown Error")
		return
	end

	print("Starting benchmarking...")
	local start = SysTime()
	local nextInfo = SysTime() + 1
	local times = {}

	for i = 1, iterations do
		local itStart = SysTime()
		exp()
		local itEnd = SysTime()
		table.insert(times, itEnd - itStart)

		if SysTime() > nextInfo then
			nextInfo = SysTime() + 1
			print("- Progress: " .. (i / iterations) * 100 .. "%")
		end
	end

	local stop = SysTime()

	print("Done! Analyzing " .. string.Comma(#times) .. " results...")
	local avg, var = 0, 0
	local min, max

	for _, time in ipairs(times) do
		if not min or min > time then
			min = time
		end
		if not max or max < time then
			max = time
		end
		avg = avg + time
	end

	avg = avg / #times

	for _, time in ipairs(times) do
		var = var + math.pow(time - avg, 2)
	end

	var = var / #times

	print("-> Runtime: " .. formatTime(stop - start))
	print("-> Minimum: " .. formatTime(min))
	print("-> Maximum: " .. formatTime(max))
	print("-> Average: " .. formatTime(avg))
	print("-> Variance: " .. var)
	print("Saving to file...")

	file.CreateDir("jet/benchmarks")
	local fileName = "jet/benchmarks/" .. math.Round(os.time()) .. ".txt"
	local f = file.Open(fileName, "w", "DATA")

	f:Write("Benchmark Report - " .. os.date("%c") .. "\n")
	f:Write("------------------------------------" .. "\n")
	f:Write("Expression: " .. table.concat(args, " ", 2) .. "\n")
	f:Write("Iterations: " .. iterations .. "\n")
	f:Write("Runtime: " .. formatTime(stop - start) .. "\n")
	f:Write("Minimum: " .. formatTime(min) .. "\n")
	f:Write("Maximum: " .. formatTime(max) .. "\n")
	f:Write("Average: " .. formatTime(avg) .. "\n")
	f:Write("Variance: " .. var .. "\n")
	f:Write("------------------------------------" .. "\n")
	f:Write("Timings below.\n\n")
	for _, time in ipairs(times) do
		f:Write("- " .. time .. "\n")
	end
	f:Close()
	print("Saved logs to " .. fileName)

end, "<iterations> <expression>", "Benchmark an expression.", "bm")
