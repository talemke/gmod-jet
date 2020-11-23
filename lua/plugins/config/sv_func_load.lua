
--[[
    Config Plugin -> Load Function (Shared)
    by Tassilo (@TASSIA710)
--]]



--- Parses a configuration line.
-- @note If this line defines a new section this function returns `nil` as key and the section name as value.
-- @param line [string] - the line
-- @returns key [string] - the config key
-- @returns value [any] - the config value
local function parseLine(line)

    -- Valid line?
    if not line then return nil, nil end
    line = string.Trim(line)
    if line == "" then return nil, nil end

    -- Comment?
    if string.StartWith(line, "//") then return nil, nil end
    if string.StartWith(line, "#") then return nil, nil end
    if string.StartWith(line, ";") then return nil, nil end

    -- Section?
    if line[1] == "[" and line[string.len(line)] == "]" then
        return nil, string.Trim(string.sub(line, 2, -2))
    end

    -- Key/Value?
    local split = string.Explode("=", line)
    if #split < 2 then return nil, nil end
    local key = string.Trim(split[1])
    local value = string.Trim(string.sub(line, string.len(split[1]) + 2))
    return key, value
end



--- Loads configuration data from a file.
-- @param fileName [string] (="jet/config.txt") - the file name
-- @param gamePath [string] (="DATA") - the game directory
-- @returns global [table] - the global values
-- @returns sections [table] - section specific values
return function(fileName, gamePath)

    -- Fallback values
    fileName = fileName or "jet/config.txt"
    gamePath = gamePath or "DATA"

    -- Read the file
    local data = file.Read(fileName, gamePath)
    if not data then return nil end
    data = string.Explode("\n", data)

    -- Define variables
    local global = {}
    local sections = {}

    -- Parse
    local section = nil
    for _, line in ipairs(data) do
        local k, v = parseLine(line)
        if v then
            if k then
                if section then
                    sections[section][k] = v
                else
                    global[k] = v
                end
            else
                section = v
            end
        end
    end

    -- Return
    return global, sections
end