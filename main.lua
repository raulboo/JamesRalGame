---@diagnostic disable: undefined-global

require("src/graphic")
require("src/controls")
require("src/player")
require("src/utilities")

-- TODO: Need decide where store variables to control general environment properties like gravity, etc
-- TODO: We need to choose libraries or build code for scene change

function love.load() 
    -- Load entire sprite sheet
    img = love.graphics.newImage("images/spriteSheet.png")

    -- Create a quad
    block1 = love.graphics.newQuad(0, 0, 16, 16, img)
    block2 = love.graphics.newQuad(16, 0, 16, 16, img)
end

function love.update(dt)
    controls(dt) -- prototype where the all player moveents will be made ?
end

function love.draw()
    -- Every draw code need to be between startCanvas and endCanvas to adapt correct to the game pixel size.
    startCanvas({0.5, 0.5, 0.5, 1})

        -- Draw the quad
        for i = 0, love.graphics.getWidth(), 16 do
            love.graphics.draw(img, block1, i, 250)
        end
        
        love.graphics.draw(img, block2, 82, 50)

    endCanvas()
end

