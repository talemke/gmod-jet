
--[[
	Jet -> Version Library (Shared)
	by Tassilo (@TASSIA710)

	This file contains the version library.
--]]


-- Define variables
jet.target = 201023
jet.version = jet.CreateVersion(1, 0, 0, 0, "b0a64a74e51cb54a5369c3e1d5c0295b1931d1b8", "main")


-- Too old?
if jet.target > VERSION then
	log.Severe("Jet requires a newer version of the game.")
	log.Severe("- Tested Version:  " .. jet.target)
	log.Severe("- Current Version: " .. VERSION)
	log.Severe("Aborting boot...")
	jet.continueBooting = false
end


-- Too new?
if jet.target < VERSION then
	log.Warning("Jet has not yet been tested for this game version. Consider checking for updates.")
	log.Warning("- Tested Version:  " .. jet.target)
	log.Warning("- Current Version: " .. VERSION)
end
