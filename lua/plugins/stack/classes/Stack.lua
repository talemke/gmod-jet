--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- A stack.
---
--- @class Stack
---
local CLASS = {}
CLASS.__index = CLASS

--- @type any[]
CLASS._Data = {}



--- Returns the size of this stack.
---
--- @return number the size
---
function CLASS:Size()
	return #self._Data
end



--- Pops the top element from the stack and returns it.
---
--- @return any|nil the top element
---
function CLASS:Pop()
	local element = self._Data[#self._Data]
	table.remove(self._Data)
	return element
end



--- Peeks at the top of the stack.
---
--- @return any|nil the top element
function CLASS:Peek()
	return self._Data[#self._Data]
end



--- Pushes an element to the top of the stack.
---
--- @param element any the element
---
function CLASS:Push(element)
	table.insert(self._Data, element)
end



--- Clears the stack.
---
function CLASS:Clear()
	self._Data = {}
end



--- Removes an element from the stack.
---
--- @param element any the element to remove
---
function CLASS:Remove(element)
	table.RemoveByValue(self._Data, element)
end



--- Removes all elements from the stack where 'predicate' returns true.
---
--- @param predicate fun(element:any):boolean the predicate
---
function CLASS:RemoveIf(predicate)
	for index, element in pairs(self._Data) do
		if predicate(element) then
			table.remove(self._Data, index)
		end
	end
end



-- Register class.
debug.getregistry()["Jet:Stack"] = CLASS
