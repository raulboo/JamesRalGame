---@diagnostic disable: undefined-global

require("src/graphic")
require("src/controls")
require("src/player")

function love.load() 
    -- variables only for test
    x = 50
    y = 50
end

function love.update(dt)
    movePlayer(dt)
end

function love.draw()
    startCanvas({0.5, 0.5, 0.5, 1})
        love.graphics.rectangle("fill", x, y, 50, 50)
    endCanvas()
end

