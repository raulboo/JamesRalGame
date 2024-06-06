---@diagnostic disable: undefined-global

require("src/graphic")
require("src/controls")
require("src/player")

-- TODO: Need decide where store variables to control general environment properties like gravity, etc
-- TODO: We need to choose libraries or build code for scene change

function love.load() 
    -- variables only for test
    x = 50
    y = 50
end

function love.update(dt)
    controls(dt) -- prototype where the all player moveents will be made ?
end

function love.draw()
    -- Every draw code need to be between startCanvas and endCanvas to adapt correct to the game pixel size.
    startCanvas({0.5, 0.5, 0.5, 1})

        love.graphics.rectangle("fill", x, y, 50, 50)

    endCanvas()
end

