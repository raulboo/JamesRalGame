---@diagnostic disable: undefined-global

require("src/graphic")

function love.load() 
    
end

function love.update(dt)
    
end

function love.draw()
    startCanvas({0.5, 0.5, 0.5, 1})
        love.graphics.rectangle("fill", 100, 100, 50, 50)
    endCanvas()
end

