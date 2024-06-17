require"ecs"

local RenderSystems = {}


RenderSystems.renderSprites = system({"pos", "sprite"},
    function(e) 
        -- IMPORTANT: sprite was not touching ground even if is touching the bottom of the cell i nthe image then I added '+ 1' to e.pos.y to fix
        if e.flipH == false then
            spr(e.sprite, e.pos.x - TILE_SIZE/2, e.pos.y - TILE_SIZE/2 + 1, 0, 1, 1, 0, 0) 
        else
            spr(e.sprite, e.pos.x - TILE_SIZE/2, e.pos.y - TILE_SIZE/2 + 1, 0, -1, 1, TILE_SIZE, 0) 
        end
    end
)


return RenderSystems