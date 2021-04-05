--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Utility function to add the ternary operator to Lua.
---
--- @note Unlike the original ternary operator,
--- 	both values will be resolved, no matter the output of the expression.
---
--- @generic A : any, B : any
--- @param expression boolean the expression
--- @param thenValue A the value for when the expression is `true`
--- @param elseValue B the value for when the expression is `false`
--- @return A|B the proper value
---
_G.either = function(expression, thenValue, elseValue)
end



--- A scope function.
---
--- @generic P : any
--- @param input P the input value
--- @param fun fun(it:P):void the function body
--- @return P the input value
---
_G.also = function(input, fun)
	fun(input)
	return input
end



--- A scope function.
---
--- @generic T : any
--- @param input T|nil the input value
--- @param fun fun(it:T):void the function body
--- @return T|nil the input value
_G.alsoNN = function(input, fun)
	if input ~= nil then
		fun(input)
		return input
	end
	return nil
end



--- A scope function.
---
--- @generic P : any, R : any
--- @param input P the input value
--- @param fun fun(it:P):R the function body
--- @return R the value returned from `fun`
---
_G.let = function(input, fun)
	return fun(input)
end



--- A scope function.
---
--- @generic P : any, R : any
--- @param input P|nil the input value
--- @param fun fun(it:P):R the function body
--- @return R|nil the value returned from `fun` or `nil` if input is `nil`
---
_G.letNN = function(input, fun)
	if input ~= nil then
		return fun(input)
	end
	return nil
end



--- A scope function.
---
--- @generic T : any
--- @param input T the input value
--- @param predicate fun(it:T):boolean the predicate
--- @return T|nil the input or `nil`, if the predicate is `false`
---
_G.takeIf = function(input, predicate)
	-- If the input is nil anyway, it doesn't really matter
	if input == nil then return nil end

	-- Check the predicate
	if predicate(input) then
		return input
	else
		return nil
	end
end



--- A scope function.
---
--- @generic T : any
--- @param input T the input value
--- @param predicate fun(it:T):boolean the predicate
--- @return T|nil the input or `nil`, if the predicate is `true`
---
_G.takeUnless = function(input, predicate)
	-- If the input is nil anyway, it doesn't really matter
	if input == nil then return nil end

	-- Check the predicate
	if predicate(input) then
		return nil
	else
		return input
	end
end
