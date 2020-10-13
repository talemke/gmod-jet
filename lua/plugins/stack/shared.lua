
--[[
	Stack Plugin -> Stack (Shared)
	by Tassilo (@TASSIA710)

	This script adds a nice stack functionality.
--]]

local STACK = {}
STACK.__index = STACK
STACK._data = {}

--- Returns the size of this stack.
-- @returns size [number] - the size
function STACK:Size()
	return #self._data
end

--- Pops the top element from the stack and returns it.
-- @returns element [any] - the top element
function STACK:Pop()
	local e = self._data[#self._data]
	table.remove(self._data)
	return e
end

--- Pushes an element to the top of the stack.
-- @param element [any] - an element
function STACK:Push(element)
	table.insert(self._data, element)
end

--- Clears the stack.
function STACK:Clear()
	self._data = {}
end

--- Removes an element from the stack.
-- @param element [any] - the element to remove
function STACK:Remove(element)
	table.RemoveByValue(self._data, element)
end

--- Removes all elements from the stack where 'where' returns true.
-- @param where [function] - a predicate
function STACK:RemoveIf(where)
	for i, e in pairs(self._data) do
		if where(e) then table.remove(self._data, i) end
	end
end

--- Peeks at the top of the stack.
-- @returns element [any] - the top element
function STACK:Peek()
	return self._data[#self._data]
end

--- Returns the internal table of the stack.
-- @returns stack [table] - the internal table
-- @internal
function STACK:_InternalTable()
	return self._data
end

--- Creates a new stack.
-- @returns [Stack] stack - a newly created stack
function Stack()
	return setmetatable({
		[0] = 0
	}, STACK)
end
