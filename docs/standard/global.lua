
--- Marks a Lua file to be sent to clients when they join the server.
--- Doesn't do anything on the client - this means you can use it
--- in a shared file without problems.
---
--- @param file string|nil The name/path to the Lua file that should be sent,
--- 	relative to the garrysmod/lua folder. If no parameter is specified,
--- 	it sends the current file.
---
AddCSLuaFile = function(file) end



--- Executes a Lua script.
---
--- @note Addon files (.gma files) do not support relative parent folders (`..` notation).
---
--- @note This function will try to load local client file if `sv_allowcslua` is **1**.
---
--- @warning The file you are attempting to include MUST NOT be empty or the include will fail.
--- 	Files over a certain size may fail as well.
---
--- @warning If the file you are including is clientside or shared, it must be [AddCSLuaFile]'d
--- 	or this function will error saying the file doesn't exist.
---
--- @param fileName string The name of the script to be executed.
--- 	The path must be either relative to the current file,
--- 	or be an absolute path (relative to and excluding the lua/ folder).
---
--- @return any Anything that the executed Lua script returns.
---
include = function(fileName) end
