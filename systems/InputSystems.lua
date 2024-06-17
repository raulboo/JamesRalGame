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
        if love.keyboard.isDown(e.punch) then
            --world:spawn("punchbox", e.pos.x + e.move.vel.x*2, e.pos.y)
        end
    end   
)




return InputSystems