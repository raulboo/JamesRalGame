require"ecs"

local RenderSystems = {}


RenderSystems.renderSprites = system({"pos", "sprite"},
    function(e) 
        spr(e.sprite, e.pos.x - TILE_SIZE/2, e.pos.y - TILE_SIZE/2)
    end
)


return RenderSystems