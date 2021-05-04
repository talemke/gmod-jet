--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- @generic V
--- @param tbl table<any, V>
--- @param predicate fun:boolean
_G.table.RemoveIf = function(tbl, predicate, ...)
	for index, element in pairs(tbl) do
		if predicate(..., element) then
			table.remove(tbl, index)
		end
	end
end



--- @generic K, V
--- @param tbl table<K, V>
--- @param predicate fun:boolean
_G.table.RemoveIfKV = function(tbl, predicate, ...)
	for index, element in pairs(tbl) do
		if predicate(..., index, element) then
			table.remove(tbl, index)
		end
	end
end



--- @generic V
--- @param tbl table<any, V>
--- @param func fun:boolean
_G.table.ForEach = function(tbl, func, ...)
	for _, element in pairs(tbl) do
		if func(..., element) then
			break
		end
	end
end



--- @generic K, V
--- @param tbl table<K, V>
--- @param func fun:boolean
_G.table.ForEach = function(tbl, func, ...)
	for index, element in pairs(tbl) do
		if func(..., index, element) then
			break
		end
	end
end



--- @generic K, V1, V2
--- @param tbl table<K, V1>
--- @param func fun:V2
--- @return table<K, V2>
_G.table.Map = function(tbl, func, ...)
	local tbl2 = {}
	for index, element in pairs(tbl) do
		tbl2[index] = func(..., element, index)
	end
	return tbl2
end



--- @generic K1, K2, V1, V2
--- @param tbl table<K1, V1>
--- @param func fun:V2,K2|nil
--- @return table<K2, V2>
_G.table.MapKV = function(tbl, func, ...)
	local tbl2 = {}
	for index, element in pairs(tbl) do
		local value, key = func(..., element, index)
		tbl2[key or index] = value
	end
	return tbl2
end
