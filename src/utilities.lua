---@diagnostic disable: lowercase-global

-- Destroy all objects in a table. Useful to clear a scene. The clear uses reversed order to avoid the jump element problem when removing from a table
function clearTable(table)
    for i = #table, 1, -1 do
        table[i] = nil
    end
end