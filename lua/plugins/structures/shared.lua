--[[
	Data Structures Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Creates a new stack.
---
--- @return Stack the created stack
---
_G.Stack = function()
	return setmetatable({}, debug.getregistry()["Jet:DataStructure:Stack"])
end
