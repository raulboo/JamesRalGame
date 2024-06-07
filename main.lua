---@diagnostic disable: undefined-global, lowercase-global

require("src/graphic")
require("src/controls")
require("src/player")
require("src/utilities")
require("src/tiles")

-- GLOBAL CONSTANTS --------------------------------

TILE_SIZE = 16

-- GLOBAL VARTIABLES --------------------------------

Gravity = 0.2

function love.load() 
     -- Load entire sprite sheet
    spriteSheet = love.graphics.newImage("images/spriteSheet.png")

    -- Crete tiles
    for i = 0, 32 do
        addTile(0, 0, i, 16)
    end

    for i = 0, 8 do
        addTile(0, 0, i, 12)
    end

    -- creating a player for test
   addPlayer(100, 100)
   addPlayer(200, 100)
end

function love.update(dt)
    controls(dt) -- prototype where the all player moveents will be made ?

    detectTiles()

    updateObject(playerTable)
    updateObject(tileTable)
    
end

function love.draw()
    -- Every draw code need to be between startCanvas and endCanvas to adapt correct to the game pixel size.
    startCanvas({0.5, 0.5, 0.5, 1})

        drawObject(tileTable)
        drawObject(playerTable)

    endCanvas()
end

