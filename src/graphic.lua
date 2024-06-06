---@diagnostic disable: undefined-global

love.graphics.setDefaultFilter("nearest", "nearest")

SCREEN_WIDTH = 480
SCREEN_HEIGHT = 270
canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

-- Color Palettes we will use. Bellow is temporary Pico-8 palette as a example
-- TODO: Change color palette to use in the game
color = {}
color.black = {0, 0, 0}
color.dark_blue = {29, 43, 83}
color.dark_purple = {126, 37, 83}
color.dark_green = {0, 135, 81}
color.brown = {171, 82, 54}
color.dark_grey = {95, 87, 79}
color.light_grey = {194, 195, 199}
color.white = {255, 241, 232}
color.red = {255, 0, 77}
color.orange = {255, 163, 0}
color.yellow = {255, 236, 39}
color.green = {0, 228, 54}
color.blue = {41, 173, 255}
color.lavender = {131, 118, 156}
color.pink = {255, 119, 168}
color.light_peach = {255, 204, 170}

function startCanvas(color)
    love.graphics.setCanvas(canvas)
    love.graphics.clear(color) -- Background color
    love.graphics.setDefaultFilter("nearest", "nearest")
end

function endCanvas()
    love.graphics.setCanvas()
    local maxScaleX = love.graphics.getWidth() / canvas:getWidth()
    local maxScaleY = love.graphics.getHeight() / canvas:getHeight()
    local scale = math.min(maxScaleX, maxScaleY)
    love.graphics.draw(canvas, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, scale, scale, canvas:getWidth() / 2, canvas:getHeight() / 2)
end