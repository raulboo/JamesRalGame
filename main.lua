---@diagnostic disable: undefined-global, lowercase-global

require("src/graphic")
require("src/controls")
require("src/player")
require("src/utilities")
require("src/tiles")

-- TODO: Need decide where store variables to control general environment properties like gravity, etc
-- TODO: We need to choose libraries or build code for scene change


function love.load() 
     -- Load entire sprite sheet
    spriteSheet = love.graphics.newImage("images/spriteSheet.png")

    -- Crete tiles
    addTile(1, 1, 1)


    -- creating a player for test
   addPlayer(100, 100)
   addPlayer(200, 100)
end

function love.update(dt)
    controls(dt) -- prototype where the all player moveents will be made ?

    updateObject(playerTable)

    if collisionDetection(playerTable[1], playerTable[2]) then
        os.execute("cls")
        print("Colided")
    end
end

function love.draw()
    -- Every draw code need to be between startCanvas and endCanvas to adapt correct to the game pixel size.
    startCanvas({0.5, 0.5, 0.5, 1})

        drawObject(tileTable)
        drawObject(playerTable)

    endCanvas()
end

