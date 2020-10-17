
--[[
	Jet -> Version Data (Shared)
	by Tassilo (@TASSIA710)

	Contains the version data.
--]]

-- version data
jet.versionMajor = 0
jet.versionMinor = 0
jet.versionPatch = 0
jet.versionBuild = 0


-- git
jet.versionHead = "b0a64a74e51cb54a5369c3e1d5c0295b1931d1b8"
jet.versionBranch = "main"


-- e.g. 1.3
jet.versionSmall = jet.versionMajor .. "." .. jet.versionMinor


-- e.g. 1.3.2
jet.version = jet.versionSmall .. "." .. jet.versionPatch


-- e.g. 1.3.2, build 71
jet.versionFull = jet.version .. ", build " .. jet.versionBuild


-- links
jet.versionReleaseLink = "https://github.com/TASSIA710/Jet/releases/tag/v" .. jet.version
jet.versionRepositoryLink = "https://github.com/TASSIA710/Jet/tree/" .. jet.versionHead
