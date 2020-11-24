
--[[
    Config Plugin -> Save Function (ServerSide)
    by Tassilo (@TASSIA710)
--]]



local function formatSection(section)
    return "[" .. section .. "]\n"
end

local function formatKeyValue(key, value, layout)
    local comment = "# No description provided."
    if layout then
        comment = "# " .. layout.description .. "\n" .. "# Default: " .. layout.default .. " (" .. table.concat(layout.types, " or ") .. ")"
    end
    return "\n" .. comment .. "\n" .. key .. "=" .. value .. "\n"
end



--- Saves configuration data to a file.
-- @param global [table] - the global config data
-- @param sections [table] - sections
-- @param globalLayout [table] - the global layout
-- @param sectionsLayout [table] - the sections layout
-- @param fileName [string] (="jet/config.txt") - the file name
-- @returns success [boolean] - `true` on success, `false` on failure
return function(global, sections, globalLayout, sectionsLayout, fileName)

    -- Fallback values
    fileName = fileName or "jet/config.txt"

    -- Open file
    local file = file.Open(fileName, "w", "DATA")
    if not file then return false end

    -- Write global data
    file:Write("# Global Configuration\n")
    for k, v in pairs(global) do
        file:Write(formatKeyValue(k, v, globalLayout[k]))
    end

    -- Write sections
    for section, data in pairs(sections) do
        file:Write("\n\n\n")
        file:Write("# Plugin " .. section .. " Configuration\n")
        file:Write(formatSection(section))
        for k, v in pairs(data) do
            file:Write(formatKeyValue(k, v, sectionsLayout[section][k]))
        end
    end

    -- Flush & close
    file:Flush()
    file:Close()
    return true
end