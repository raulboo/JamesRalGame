require"utilities"

local STAGE_LABEL_TABLE = require"stages.STAGE_LABEL_TABLE"

-- Think of this as a Class
local Stage = {}

function Stage.load(label) 
    local stage_data = require(STAGE_LABEL_TABLE[label])
    local size = Vec2(stage_data.width, stage_data.height)

    local tile_layer  = stage_data.layers[1]
    local spawn_layer = stage_data.layers[2]

    local new_stage = {
        size           = size,
        edges          = size*TILE_SIZE,
        display_name   = tile_layer.name,
        respawn_points = tableMap(
            spawn_layer.objects, 
            function(point) return Vec2(math.floor(point.x), math.floor(point.y)) end
        ),

        tiles = tile_layer.data
    }    

    -- make new_stage inherit the class Stage
    setmetatable(new_stage, {__index=Stage})

    return new_stage
end

--function Stage:update() end 

-- Can only be used if PicoAPI is required
function Stage:drawTiles() 
    for idx, sprite in ipairs(self.tiles) do
        if sprite~=0 then 
            local i = idx-1 -- corrected index so modulo function (%) will work
            local x = i % self.size.x
            local y = math.floor(i / self.size.x)

            -- TODO: We should actually table:map the self.tiles in Stage.load, 
            -- the issue is that sprite 0 in Tiled is translated to Lua as 1, 1 as 2, an so on
            -- and 0 is reserved as the "transparent" tile
            spr(sprite-1, x * TILE_SIZE, y * TILE_SIZE, rotation, 1, 1, 0, 0)
        end 
    end
end

function Stage:getTileAt(x,y)
    local idx = (math.floor(x / TILE_SIZE)) + (self.size.x * math.floor(y / TILE_SIZE))
    return self.tiles[idx+1] or 0
end

--function Stage:getTilesAtArea(center, size) end

-- currently assuming everything is solid
function Stage:isSolidAt(x,y)
    return (self:getTileAt(x,y) > 0)
end

function Stage:isSolidInArea(center, size)
    local top_left  = center - (size*0.5)
    local bot_right = center + (size*0.5) 

    if self:isOutOfBounds(top_left) or self:isOutOfBounds(bot_right) then
        return nil 
    end

    for x = top_left.x, bot_right.x, TILE_SIZE/2 do
        for y = top_left.y, bot_right.y, TILE_SIZE/2 do
            if self:isSolidAt(x,y) then return true end
        end
    end
    return false
end

function Stage:isOutOfBounds(point)
    return (point.x < 0 or point.x > self.edges.x or point.y < 0 or point.y > self.edges.y)
end

return Stage