
--- Add a hook to be called upon the given event occurring.
---
--- @param eventName string The event to hook on to. This can be any **GM** hook, gameevent
--- 	after using [gameevent.Listen], or custom hook run with [hook.Call] or [hook.Run].
---
--- @param identifier string The unique identifier, usually a string. This can be used elsewhere
--- 	in the code to replace or remove the hook. The identifier should be unique so that you do
--- 	not accidentally override some other mods hook, unless that's what you are trying to do.
---
--- @param func function The function to be called
---
_G.hook.Add = function(eventName, identifier, func) end



--- Calls all hooks associated with the given event until one returns something other than nil,
--- and then returns that data. In almost all cases, you should use hook.Run instead - it calls
--- [hook.Call] internally but supplies the gamemode table by itself, making your code neater.
---
--- @param eventName string The event to call hooks for
---
--- @param gamemodeTable table If the gamemode is specified, the gamemode hook within will be called, otherwise not
---
--- @vararg any The arguments to be passed to the hooks
---
--- @return vararg Return data from called hooks. Limited to 6 return values
---
_G.hook.Call = function(eventName, gamemodeTable, ...) end



--- Returns a list of all the hooks registered with [hook.Add].
---
--- @return table A table of tables.
---
_G.hook.GetTable = function() end



--- Removes the hook with the supplied identifier from the given event.
---
--- @param eventName string The event name.
---
--- @param identifier string The unique identifier of the hook to remove, usually a string.
---
_G.hook.Remove = function(eventName, identifier) end



--- Calls hooks associated with the given event. Calls all hooks until one returns something other than `nil`
--- and then returns that data. If no hook returns any data, it will try to call the `GAMEMODE:<eventName>`
--- alternative, if one exists. This function internally calls [hook.Call]. See also: [gamemode.Call] - same as this,
--- but does not call hooks if the gamemode hasn't defined the function.
---
--- @param eventName string The event to call hooks for
---
--- @vararg any The arguments to be passed to the hooks
---
--- @return vararg Returned data from called hooks
---
_G.hook.Run = function(eventName, ...) end
