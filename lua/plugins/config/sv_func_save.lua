
--[[
    Config Plugin -> Save Function (ServerSide)
    by Tassilo (@TASSIA710)
--]]



local function formatSection(section)
    return "[" .. section .. "]\n"
end

local function formatKeyValue(key, value)
    return key .. "=" .. value .. "\n"
end



--- Saves configuration data to a file.
-- @param global [table] - the global config data
-- @param sections [table] - sections
-- @param fileName [string] (="jet/config.txt") - the file name
-- @returns success [boolean] - `true` on success, `false` on failure
return function(global, sections, fileName)

    -- Fallback values
    fileName = fileName or "jet/config.txt"

    -- Open file
    local file = file.Open(fileName, "w", "DATA")
    if not file then return false end

    -- Write global data
    for k, v in pairs(global) do
        file:Write(formatKeyValue(k, v))
    end

    -- Write sections
    for section, data in pairs(sections) do
        file:Write("\n" .. formatSection(section))
        for k, v in pairs(data) do
            file:Write(formatKeyValue(k, v))
        end
    end

    -- Flush & close
    file:Flush()
    file:Close()
    return true
end