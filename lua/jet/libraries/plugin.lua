
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
-- @since v1.0.0
function jet.GetPlugin(name)
	return plugins[name]
end



--- Returns a table of all plugins mapped to their identifiers.
-- @returns plugins [table] - all plugins
-- @since v1.0.0
function jet.GetPlugins()
	return plugins
end



--- Loads all plugins.
-- @internal
-- @since v1.0.0
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

	-- Run post hook
	--- Called after all plugins have been loaded.
	-- @param pluginsFound [number] - how many plugins were available to be loaded
	-- @param loaded [number] - how many plugins were actually loaded
	hook.Run("PluginsLoaded", #pluginsFound, loaded)
end



--- Tests all plugins.
-- @since v1.0.0
function jet.TestPlugins()
	log.Info("[Jet] Testing plugins...")
	local total, success = 0, 0

	-- Test
	for _, pl in pairs(jet.GetPlugins()) do
		total = total + 1
		if not pl:IsTestable() then continue end
		log.Debug("[Jet] - " .. pl:GetIdentifier())
		if pl:Test() then
			success = success + 1
		end
	end

	-- Info
	if total == success then
		log.Info("[Jet] Tested all " .. total .. " plugins.")
	else
		log.Info("[Jet] Tested " .. success .. " out of " .. total .. " available plugins.")
	end
end
