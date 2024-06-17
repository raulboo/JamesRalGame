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

function spr(idx, x, y) 
    assert(_loaded_spritesheet and _spritesheet_map, "Tried calling spr() with no spritesheet loaded")

    love.graphics.draw(_loaded_spritesheet, _spritesheet_map[idx], x, y)
end

--function pal() _loaded_spritesheet:replacePixels() end

--function print() end