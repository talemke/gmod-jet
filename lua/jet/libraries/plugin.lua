
--[[
	Jet -> Plugin Library (Shared)
	by Tassilo (@TASSIA710)

	This library handles all plugins.
--]]

local plugins = {}



--- Returns the plugin matching the given identifier. A plugin identifier
-- looks like this: `Author/PluginName`, e.g. `TASSIA710/CLI`
-- @param name [string] - the plugin identifier
-- @returns plugin [Plugin] - the plugin
function jet.GetPlugin(name)
	return plugins[name]
end



--- Returns a table of all plugins mapped to their identifiers.
-- @returns plugins [table] - all plugins
function jet.GetPlugins()
	return plugins
end



--- Loads all plugins.
-- @internal
function jet.LoadPlugins()
	log.Info("[Jet] Loading plugins...")

	-- Prepare
	plugins = {}
	local pluginsFound = {}
	local loaded = 0
	local _, dirs = file.Find("plugins/*", "LUA")

	-- Find plugins
	log.Debug("[Jet] Locating plugins...")
	for _, dir in pairs(dirs) do
		table.insert(pluginsFound, jet.GetPluginByPath(dir))
	end

	-- Initialize plugins
	log.Debug("[Jet] Verifying plugins...")
	for _, pl in pairs(pluginsFound) do
		local status, err = pl:Init()
		if status then
			plugins[pl:GetIdentifier()] = pl
		else
			log.Warning("[Jet] Cannot load plugin '" .. pl:GetPathName() .. "':", err)
		end
	end

	-- Load plugins
	log.Debug("[Jet] Continuing load process...")
	for _, pl in pairs(plugins) do
		if pl:IsDisabled() then
			log.Debug("[Jet] - " .. pl:GetIdentifier() .. " @ v" .. pl:GetVersion():ToString() .. " (disabled)")
		else
			log.Debug("[Jet] - " .. pl:GetIdentifier() .. " @ v" .. pl:GetVersion():ToString())
			pl:Load()
			loaded = loaded + 1
		end
	end

	-- Info
	if loaded == #pluginsFound then
		log.Info("[Jet] Loaded all " .. loaded .. " plugins.")
	else
		log.Info("[Jet] Loaded " .. loaded .. " out of " .. #pluginsFound .. " available plugins.")
	end
end
