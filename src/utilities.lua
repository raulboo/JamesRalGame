---@diagnostic disable: lowercase-global

function updateObject(object, dt)
    for i, v in pairs(object) do
        v:update(dt)
    end
end

-- Destroy all objects in a table. Useful to clear a scene. The clear uses reversed order to avoid the jump element problem when removing from a table
function clearTable(table)
    for i = #table, 1, -1 do
        table[i] = nil
    end
end

function collisionDetection(tableA, tableB)
    return  tableA.cx1 < tableB.cx2 and
            tableA.cx2 > tableB.cx1 and
            tableA.cy1 < tableB.cy2 and
            tableA.cy2 > tableB.cy1
end

function detectTiles()
    for i1, v1 in ipairs(tileTable) do
        for i, v in ipairs(playerTable) do
            if collisionDetection(tileTable[i1], playerTable[i]) then
                print("boing")
            end
        end
    end
end