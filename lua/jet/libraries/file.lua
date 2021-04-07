--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Searches for all files in the pathName, matching the pattern recursively.
--- That is, it also searches all sub folders of the original pathName.
---
--- @param pathName string the path to search in
--- @param pattern string the files to search for
--- @param pattern string the path (e.g. `"LUA"`)
--- @param consumer fun(dir:string,file:string) the consumer
---
_G.file.FindRecursive = function(pathName, pattern, path, consumer)
	local files, _ = file.Find(pathName .. pattern, path)
	for _, file in ipairs(files) do
		consumer(pathName, file)
	end

	local _, dirs = file.Find(pathName .. "*", path)
	for _, dir in ipairs(dirs) do
		file.FindRecursive(pathName .. dir .. "/", pattern, path, consumer)
	end
end
