
--- The table of the currently active gamemode, outside the gamemode files.
---
--- @type table
---
_G.GAMEMODE = nil



--- Same as [GAMEMODE], but only exists gamemode files. (`gamemodes/<gamemodeName>/gamemode/*.lua`)
---
--- @type table
---
_G.GM = nil



--- Similar to [GM], but for Scripted Entities. Exists only in the files defining the entity. (`lua/entities/*.lua`)
---
--- @type table
---
_G.ENT = nil



--- Similar to [ENT], but for Scripted Weapons. Exists only in the files defining the weapon. (`lua/weapons/*.lua`)
---
--- @type table
---
_G.SWEP = nil



--- Similar to [ENT], but for Scripted Effects. Exists only in the files defining the effect. (`lua/effects/*.lua`)
---
--- @type table
---
_G.EFFECT = nil



--- Contains a list of all modules loaded from `/modules/`.
---
--- @type table
---
_G.MODULES = nil



--- This is true whenever the current script is executed on the client. (client and menu states) Always present.
---
--- @type boolean
---
_G.CLIENT = nil



--- This is true whenever the current script is executed on the client state.
---
--- @type boolean|nil
---
_G.CLIENT_DLL = nil



--- This is true whenever the current script is executed on the server state. Always present.
---
--- @type boolean
---
_G.SERVER = nil



--- This is true whenever the current script is executed on the server state.
---
--- @type boolean|nil
---
_G.GAME_DLL = nil



--- This is true when the script is being executed in the menu state.
---
--- @type boolean|nil
---
_G.MENU_DLL = nil



--- Contains the name of the current active gamemode.
---
--- @type string|nil
---
_G.GAMEMODE_NAME = nil



--- Represents a non existent entity.
---
--- @type userdata
---
_G.NULL = nil



--- Contains the version number of GMod. Example: `201211`
---
--- @type number
---
_G.VERSION = nil



--- Contains a nicely formatted version of GMod. Example: `"2020.12.11"`
---
--- @type string
---
_G.VERSIONSTR = nil



--- The branch the game is running on. This will be `"unknown"` on main branch.
---
--- @type string
---
_G.BRANCH = nil
