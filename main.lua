---@diagnostic disable: undefined-global, lowercase-global

require("src/graphic")
require("src/controls")
require("src/player")
require("src/utilities")
require("src/tiles")
require("src/geometry")

require("ecs")

-- GLOBAL CONSTANTS --------------------------------

TILE_SIZE = 16

-- GLOBAL VARTIABLES --------------------------------

Gravity = 0.2


world = {}



function love.load() 
     -- Load entire sprite sheet
    spriteSheet = love.graphics.newImage("images/spriteSheet.png")

    -- Crete tiles
    for i = 0, 32 do
        addTile(0, 0, i, 16)
    end

    for i = 0, 8 do
        addTile(0, 0, i + 3, 12)
    end

    addTile(0, 0, 16, 10)
    addTile(0, 0, 16, 11)
    addTile(0, 0, 16, 12)
    addTile(0, 0, 16, 13)
    addTile(0, 0, 16, 14)

    -- creating a player for test
   addPlayer(100, 100)
   addPlayer(200, 100)

    table.insert(world, {
        type   = "player",
        pos    = {x = 120, y = 120},
        sprite = love.graphics.newQuad(0, 16, 16, 16, spriteSheet)
    })
end

function love.update(dt)
    controls(dt) -- prototype where the all player moveents will be made ?

    detectTiles()

    updateObject(playerTable)
    updateObject(tileTable)
end

function love.draw()
    -- systems


    -- Every draw code need to be between startCanvas and endCanvas to adapt correct to the game pixel size.
    startCanvas({0.5, 0.5, 0.5, 1})

        drawObject(tileTable)
        drawObject(playerTable)

        displaySprites(world)

    endCanvas()
end

displaySprites = system({"pos", "sprite"},
    function(e)
        love.graphics.draw(spriteSheet, e.sprite, e.pos.x, e.pos.y)
    end
)
