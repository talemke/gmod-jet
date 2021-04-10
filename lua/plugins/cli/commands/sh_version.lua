--[[
	CLI Plugin - (c) 2021 Tassilo <https://tassia.net>
	Licensed under the MIT License.
--]]

Jet:CLI():AddSharedCommand("version", function(ply, args, flags)

	assert(#args == 0)

	Jet:CLI():Info("Running Jet v" .. tostring(Jet.VERSION) .. " - by " .. Jet.AUTHORS)
	Jet:CLI():Info("Licensed under the " .. Jet.LICENSE .. " License.")

end)
