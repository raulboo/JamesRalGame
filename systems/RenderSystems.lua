require"ecs"

local RenderSystems = {}


RenderSystems.renderSprites = system({"pos", "sprite"},
    function(e) 
        -- IMPORTANT: sprite was not touching ground even if is touching the bottom of the cell i nthe image then I added '+ 1' to e.pos.y to fix
        spr(e.sprite, e.pos.x - TILE_SIZE/2, e.pos.y - TILE_SIZE/2 + 1) 
    end
)


return RenderSystems