--[[
	Config Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]

if not Jet:Plugins():IsPluginLoaded("jet:cli") then
	return
end

Jet:CLI():AddConsoleCommand("config", function(args, flags)
	local file = flags["file"] or "jet/config.json"

	if args[1] == "load" then
		Jet:CLI():Info("Loading config...")
		Jet:Config():Load(file)
		Jet:CLI():Info("Config has been loaded successfully.")

	elseif args[1] == "save" then
		Jet:CLI():Info("Saving config...")
		Jet:Config():Save(file)
		Jet:CLI():Info("Config has been saved successfully.")

	else
		Jet:CLI():Error("Incorrect syntax.")
	end
end)
