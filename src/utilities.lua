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
    return  tableA.collision.position.x < tableB.collision.width  and
            tableA.collision.width      > tableB.collision.position.x      and
            tableA.collision.position.y < tableB.collision.height and
            tableA.collision.height     > tableB.collision.position.y
end

function detectTiles()
    for i1, v1 in ipairs(tileTable) do
        for i, v in ipairs(playerTable) do

            if collisionDetection(tileTable[i1], playerTable[i]) then
                

                if  playerTable[i].position.y + TILE_SIZE / 2 < tileTable[i1].position.y + TILE_SIZE / 2 then
                    playerTable[i].velocity.y = 0
                    playerTable[i].position.y =  math.floor(playerTable[i].position.y - 1)
                    playerTable[i].grounded = true
                end

                playerTable[i]:update(dt)
            end
        end
    end
end

