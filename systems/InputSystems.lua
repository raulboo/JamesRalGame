require"ecs"

local InputSystems = {}

-- /systems/InputSystems.lua   -> walkPlayer(), jumpPlayer(), makePunchPlayer()

InputSystems.walkPlayer = system({"move", "walk", "controls"},
    function(e)
        if love.keyboard.isDown(e.controls.walk_left)  then e.move.vel.x = e.move.vel.x - e.walk.accel  end
        if love.keyboard.isDown(e.controls.walk_right) then e.move.vel.x = e.move.vel.x +  e.walk.accel end
    end
)

InputSystems.jumpPlayer = system({"move", "jump", "controls"},
    function(e)
        if e.grounded and love.keyboard.isDown(e.controls.jump) then
            e.move.vel.y = e.move.vel.y - e.jump.speed
            e.grounded   = false
        end
    end
)

-- to be implemented
InputSystems.makePunchPlayer = system({"move", "punch", "controls"},
    function(e)
        if love.keyboard.isDown(e.controls.punch) and e.punch.cooldown==0 then
            local direction = Vec2(e.move.vel.x/math.abs(e.move.vel.x), love.keyboard.isDown(e.controls.jump) and -1 or 0)

            local punchbox  = world:spawn("punchbox", e.pos.x + e.move.vel.x*2, e.pos.y + direction.y*8)
            punchbox.force  = e.punch.force * Vec2(direction.x,1)
            punchbox.owner  = e
            punchbox.move   = e.move

            e.punch.cooldown = e.punch.cooldown_total

        elseif e.punch.cooldown > 0 then 
            e.punch.cooldown = math.max(0, e.punch.cooldown - 1)
        end
    end   
)




return InputSystems