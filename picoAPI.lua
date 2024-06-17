-- Color Palettes we will use. Bellow is temporary Pico-8 palette as a example
-- TODO: Change color palette to use in the game
COLOR = {}
COLOR.black       = {0, 0, 0}
COLOR.dark_blue   = {29, 43, 83}
COLOR.dark_purple = {126, 37, 83}
COLOR.dark_green  = {0, 135, 81}
COLOR.brown       = {171, 82, 54}
COLOR.dark_grey   = {95, 87, 79}
COLOR.light_grey  = {194, 195, 199}
COLOR.white       = {255, 241, 232}
COLOR.red         = {255, 0, 77}
COLOR.orange      = {255, 163, 0}
COLOR.yellow      = {255, 236, 39}
COLOR.green       = {0, 228, 54}
COLOR.blue        = {41, 173, 255}
COLOR.lavender    = {131, 118, 156}
COLOR.pink        = {255, 119, 168}
COLOR.light_peach = {255, 204, 170}

SCREEN_WIDTH = 480
SCREEN_HEIGHT = 270
love.graphics.setDefaultFilter("nearest", "nearest")
local _canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

local _loaded_spritesheet --= nil
local _spritesheet_map    --= nil

function loadPicoSpritesheet(image_path, sprite_w, sprite_h)
    _loaded_spritesheet = love.graphics.newImage(image_path)

    local width, height = _loaded_spritesheet:getDimensions()
    local sprite_total  = (width/sprite_w) * (height/sprite_h)

    -- if sprite_total is not a whole number, something must have gone wrong in the image provided
    assert((sprite_total%1)==0, "Tried to load spritesheet at "..image_path.." , expected sheet with sprites of "..sprite_w.."x"..sprite_h.." size")


    _spritesheet_map = {}
    -- pre-process and make a table full of quads, representing each sprite 
    for i=0, sprite_total-1 do
        local top_left_corner_x = (i * sprite_w) % width
        local top_left_corner_y = math.floor(i*sprite_w / width) * sprite_h

        _spritesheet_map[i] = love.graphics.newQuad(
            top_left_corner_x, top_left_corner_y, 
            sprite_w, sprite_h, 
            _loaded_spritesheet
        )
    end
end

function startCanvas(color)
    love.graphics.setCanvas(_canvas)
    love.graphics.clear(color) -- Background color
end

function endCanvas()
    love.graphics.setCanvas()
    local maxScaleX = love.graphics.getWidth() / _canvas:getWidth()
    local maxScaleY = love.graphics.getHeight() / _canvas:getHeight()
    local scale = math.min(maxScaleX, maxScaleY)
    love.graphics.draw(_canvas, 
        love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 
        scale, scale, 
        _canvas:getWidth() / 2, _canvas:getHeight() / 2
    )
end

function spr(idx, x, y) 
    assert(_loaded_spritesheet and _spritesheet_map, "Tried calling spr() with no spritesheet loaded")

    love.graphics.draw(_loaded_spritesheet, _spritesheet_map[idx], x, y)
end

--function pal() _loaded_spritesheet:replacePixels() end

--function print() end

