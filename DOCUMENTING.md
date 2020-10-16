# Documenting
This is a guideline on how to write documentation comments.


## General
The general layout of a documentation comment is this:
```lua
--- This is the description of the function.
function SomeFunction() end

--- This is a longer description of a function
-- They can also be multiple lines long. Notice
-- how only the first line is appended to 3 dashes.
-- *Markdown* is also supported.
function SomeFunction2() end
```


## Parameters
If your function takes in parameters, you should also define in your documentation.\
**Note:** Class names should be named how they are listed [on the official Wiki](https://wiki.facepunch.com/gmod/).
This means the name for text will be `string`, but the class for a player will be `Player` (notice the casing).
```lua
--- This is a function that takes in two parameters.
-- @param paramA [string] - the first parameters description
-- @param paramB [string] - the second parameters description
function SomeFunction(paramA, paramB) end

--- Parameters can also have different types.
-- @param paramA [string|number] - the first parameter can either be a string or a number
-- @param paramB [any] - the second parameter can literally be anything
function SomeFunction2(paramA, paramB) end

--- Parameters can also have fallback types.
-- @param paramA [string|number] (=64) - the first parameter will default to 64 when not supplied
-- @param paramB [any] (='Hello World!') - the second parameter will default to 'Hello World!' when not supplied
function SomeFunction3(paramA, paramB) end
```


## Return values
Returns values work very similar to parameters.
```lua
--- This is a function that returns value.
-- @returns id [string] - the generated id
function SomeFunction() end

--- This function returns multiple values.
-- @returns team [string] - the name of the team
-- @returns players [table] - a table containing all players part of the team
function SomeFunction2() end
```


## Special fields

### Deprecated
You can easily mark functions as deprecated using the `@deprecated` keyword.
```lua
--- This function is deprecated.
-- @deprecated
function PLAYER:SomeFunction() end

--- You can also specify instructions on how to handle this.
-- @deprecated use PLAYER:SomeFunction3() instead
function PLAYER:SomeFunction3() end
```

### Internal
You can also mark functions as internal using the `@internal` keyword.
```lua
--- This is an internal function.
-- @internal
function PLAYER:SomeFunction() end

--- This is an internal function with instructions.
-- @internal use PLAYER:SomeFunction3() instead
function PLAYER:SomeFunction2() end
```

### Notes
You can also add notes to your function.
```lua
--- Another cool function.
-- @note This function only works on sandbox derived gamemodes.
function SomeFunction() end
```
You can also add multiple notes if you wish to do so.

### Alias
If your function is an alias, you can simply use the `@aliasof` keyword.
No other description is required.
```lua
--- Returns the Steam username of this player.
-- @returns nick [string] - the steam username
function PLAYER:Nick() end

--- @aliasof Player:Nick
function PLAYER:Name() end
```

### Author
If you want to specify an author for a function to contact in case of questions, etc.
you can do so using the `@author` keyword.
```lua
--- This cool function has been created by me!
-- @author Tassilo <tassia710@gmail.com>
function SomeFunction() end
```
**Note:** You don't have specify your email. A link to your website, your GitHub profile, your
Steam profile or anything else is also possible. However you should include a method to contact you.

### Since
If you wish to specify the release since when a function is available you can easily do so.\
**Note:** The release name should match a GitHub release or tag.
```lua
--- This function is available since release v3.0.4.
-- @since v3.0.4
function SomeFunction() end
```

### Realm
You can also override the realm for a function. If this is not supplied, the parser will assume the realm
depending on your file prefix (`cl_`, `sh_` or `sv_`).
```lua
--- This function is only available serverside.
-- @realm server
function SomeFunction() end
```


### LocalPlayer only
If your metafunction or hook only works on the local-player when run clientside
you can add this keyword.
```lua
--- This function will only work on the local player.
-- @localonly
function PLAYER:Notify(text) end
```


### Asynchronous Function
If your function is asynchronous, meaning the function is returning before its
queued actions take effect (such as e.g. DB queries, HTTP requests), you can
add the `async` keyword to it.
```lua
--- Load crucial database data.
-- @param callback [function] - called when done
-- @async
function LoadDB(callback) end
```


### Blocking Function
Do you have a blocking function? Then you can use the `blocking` keyword.
A function is blocking, if it takes an unusual amount of time to finish.
The most basic rule to determine whether your function is 'blocking' is
to check whether it should be run on a frequent hook (e.g. HUDPaint).
```lua
--- Loops through multiple huge tables and sorts them.
-- @blocking
function ExpensiveFunction() end
```


### Context
Does your function require a specific context (e.g. 2D for drawing)?
Valid contexts are:
- `2D`
- `3D`
- `any`
```lua
--- Draw cool circles on the screen!
-- @context 2D
function DrawCoolCircles() end
```


## Hooks
All the documentation rules also apply to hooks.
```lua
--- Called upon an animation event, this is the ideal place to call player animation functions
-- such as Player:AddVCDSequenceToGestureSlot, Player:AnimRestartGesture and so on.
-- @param ply [Player] - Player who is being animated
-- @param event [number] - Animation event. See Enums/PLAYERANIMEVENT
-- @param data [number] (=0) - The data for the event. This is interpreted as an Enums/ACT by `PLAYERANIMEVENT_CUSTOM` and `PLAYERANIMEVENT_CUSTOM_GESTURE`, or a sequence by `PLAYERANIMEVENT_CUSTOM_SEQUENCE`.
-- @returns activity [number] - The translated activity to send to the weapon. See Enums/ACT. Return `ACT_INVALID` if you don't want to send an activity.
hook.Run("DoAnimationEvent", ply, event, data)
```


## Network strings
You can also document network strings if you like.
```lua
--- This is called to make a notification popup on the client.
-- @direction SV --> CL
util.AddNetworkString("Notify")
```
**Note:** The `@direction` keyword can have either `SV --> CL`, `SV <-- CL` or `SV <-> CL` as value. If something else
is present or the keyword as a whole is absent, `SV <-> CL` is assumed.
