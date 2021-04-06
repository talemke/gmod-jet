--[[
	Jet - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]



--- Holds information about a specific plugin.
---
--- @class PluginInformation
---
local CLASS = {}
CLASS.__index = CLASS



--- The name of the folder containing the plugin.
--- This is set automatically, you shouldn't set this yourself.
---
--- @type string
---
CLASS.FolderName = nil



--- The group ID of this plugin. This should be a typical Maven/Gradle group ID, so for example: `net.tassia`.
--- Allow characters are: `a-z`, `-`, `_`, `.`. The max. length is 63 characters.
---
--- @type string
---
CLASS.GroupID = nil

--- The identifier for this plugin. This is the name in an URL-safe manner.
--- Allowed characters are: `a-z`, `-`, `_`. The max. length is 63 characters.
---
--- @type string
---
CLASS.PluginID = nil

--- The current version of this plugin.
---
--- @type Version
---
CLASS.Version = nil

--- The name of this plugin in a nicely formatted (spaces, casing) manner.
---
--- @type string
---
CLASS.Name = nil

--- A brief description for this plugin.
---
--- @type string|nil
---
CLASS.Description = nil

--- A list containing all authors of this plugin.
---
--- @type string[]
---
CLASS.Authors = {}



--- The server-side entrypoint of this plugin.
---
--- @type string|nil
---
CLASS.EntrypointServer = "server.lua"

--- The shared entrypoint of this plugin.
---
--- @type string|nil
---
CLASS.EntrypointShared = "shared.lua"

--- The client-side entrypoint of this plugin.
---
--- @type string|nil
---
CLASS.EntrypointClient = "client.lua"



--- Whether shared files (starting with `"sh"` or `"shared"`) should be downloaded automatically.
---
--- @type boolean
---
CLASS.AutoDownloadSharedFiles = true

--- Whether client-side files (starting with `"cl"` or `"client"`) should be downloaded automatically.
---
--- @type boolean
---
CLASS.AutoDownloadClientFiles = true



--- Whether the plugin's effects should be loaded automatically.
---
--- @type boolean
---
CLASS.AutoLoadEffects = true

--- Whether the plugin's entities should be loaded automatically.
---
--- @type boolean
---
CLASS.AutoLoadEntities = true

--- Whether the plugin's weapons should be loaded automatically.
---
--- @type boolean
---
CLASS.AutoLoadWeapons = true

--- Whether the plugin's libraries should be loaded automatically.
---
--- @type boolean
---
CLASS.AutoLoadLibraries = true

--- Whether the plugin's classes should be loaded automatically.
---
--- @type boolean
---
CLASS.AutoLoadClasses = true



--- Defines the load order of this plugin.
---
--- @type string[]
---
CLASS.LoadOrder = {
	"classes",
	"libraries",
	"shared",
	"server",
	"client",
	"weapons",
	"entities",
	"effects",
}



--- A list of dependencies for this plugin.
--- These will be loaded, before this plugin is loaded.
--- If one of the specified dependencies does not exist,
--- this plugin will not be loaded.
---
--- @type PluginDependency[]
---
CLASS.Dependencies = {}

--- A list of soft-dependencies for this plugin.
--- These will be loaded, before this plugin is loaded.
--- However, if a soft-dependency is not present, it
--- will not prevent this plugin from loading.
---
--- @type PluginDependency[]
---
CLASS.SoftDependencies = {}



--- Whether this plugin is private. This prevents
--- accidental publishing.
---
--- @type boolean
---
CLASS.Private = false

--- A link to the homepage for this plugin.
---
--- @type string|nil
---
CLASS.Homepage = nil

--- The license of this plugin. If provided, this should be
--- an [SPDX license identifier](https://spdx.org/licenses/).
---
--- @type string|nil
---
CLASS.License = nil

--- A link to a page for reporting bugs for this plugin.
--- This can be, for example, the issues section on GitHub.
---
--- @type string|nil
---
CLASS.Bugs = nil

--- A link to a funding page for this plugin.
---
--- @type string|nil
---
CLASS.Funding = nil

--- The link to the Git repository of this plugin.
---
--- @type string|nil
---
CLASS.Repository = nil



--- Returns the identifier for this plugin.
---
--- @return string the identifier
---
function CLASS:Identifier()
	return self.GroupID + ":" + self.PluginID
end



-- Register class.
debug.getregistry()["Jet:PluginInformation"] = CLASS
