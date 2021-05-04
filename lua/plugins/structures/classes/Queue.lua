--[[
	Data Structures Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- A queue. Uses a sequential Lua table internally.
---
--- @class Queue
---
local CLASS = {}
CLASS.__index = CLASS

--- @type any[]
CLASS._Data = {}



--- Returns the size of this queue.
---
--- @return number the size
---
function CLASS:Size()
	return #self._Data
end



--- Pops the first element from the queue and returns it.
---
--- @return any|nil the top element
---
function CLASS:Pop()
	local element = self._Data[1]
	table.remove(self._Data, 1)
	return element
end



--- Peeks at the front of the queue.
---
--- @return any|nil the top element
function CLASS:Peek()
	return self._Data[1]
end



--- Appends an element to the queue.
---
--- @param element any the element
---
function CLASS:Push(element)
	table.insert(self._Data, element)
end



--- Clears the queue.
---
function CLASS:Clear()
	self._Data = {}
end



--- Removes an element from the queue.
---
--- @param element any the element to remove
---
function CLASS:Remove(element)
	table.RemoveByValue(self._Data, element)
end



--- Removes all elements from the queue where 'predicate' returns true.
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
debug.getregistry()["Jet:DataStructure:Queue"] = CLASS
