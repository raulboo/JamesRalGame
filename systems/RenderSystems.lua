require"ecs"

local RenderSystems = {}

RenderSystems.renderSprites = system({"pos", "sprite"},
    function(e)
        
        if e.drawState == "grounded" and e.punchSpriteCountdown < 0 then
            animationPlayer(e, 64, 71, 0.1)
        end
        if e.drawState == "walking" and e.grounded and e.punchSpriteCountdown < 0 then
            animationPlayer(e, 73, 75, 0.1)
        end
        if e.drawState == "air" and e.move.vel.y < 0 and e.punchSpriteCountdown < 0 then
            e.sprite = 71
        end
        if e.drawState == "air" and e.move.vel.y > 0 and e.punchSpriteCountdown < 0 then
            e.sprite = 72
        end
        if e.drawState == "punch" then
            e.sprite = 77
        end

        -- player color
        if e.player_index == 2 then
            love.graphics.setColor(1, 0.2, 0.2, 1)
        end

        local sprite_size = TILE_SIZE * e.scale
        spr(e.sprite, e.pos.x - sprite_size/2, e.pos.y - sprite_size/2, e.flipH, false, e.scale)

        --[[
        if e.flipH == false then
            spr(e.sprite, e.pos.x - TILE_SIZE/2, e.pos.y - TILE_SIZE/2 + 1, 0, 1, 1, 0, 0) 
        else
            spr(e.sprite, e.pos.x - TILE_SIZE/2, e.pos.y - TILE_SIZE/2 + 1, 0, -1, 1, TILE_SIZE, 0) 
        end
        ]]--
        love.graphics.setColor(1, 1, 1, 1)
    end
)


return RenderSystems