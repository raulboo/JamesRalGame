require"ecs"

local InputSystems = {}

-- /systems/InputSystems.lua   -> walkPlayer(), jumpPlayer(), makePunchPlayer()

InputSystems.walkPlayer = system({"move", "walk", "controls"},
    function(e)
        if love.keyboard.isDown(e.controls.walk_left)  then
            e.move.vel.x = e.move.vel.x - e.walk.accel * deltaTime
            e.flipH     = true
            if e.grounded then e.drawState = "walking" end
        end
        if love.keyboard.isDown(e.controls.walk_right) then
            e.move.vel.x = e.move.vel.x +  e.walk.accel  * deltaTime
            e.flipH     = false
            if e.grounded then e.drawState = "walking" end
        end
    end
)

InputSystems.jumpPlayer = system({"move", "jump", "controls"},
    function(e)
        if e.grounded and love.keyboard.isPressed(e.controls.jump) then
            e.move.vel.y = e.move.vel.y - e.jump.speed * deltaTime
            e.grounded   = false
            e.drawState  = "air"
            sound.jump:play()
        end
    end
)

-- to be implemented
InputSystems.makePunchPlayer = system({"move", "punch", "controls", "grav"},
    function(e)
        e.punchSpriteCountdown = e.punchSpriteCountdown - 1

        if love.keyboard.isPressed(e.controls.punch) and e.punch.cooldown==0 then
            local direction = Vec2(e.move.vel.x/math.abs(e.move.vel.x), love.keyboard.isDown(e.controls.jump) and -1 or 0)

            local punchbox   = nil
            local punshReach = 4 -- a punch reach this distance from the character
            local boxHeight  = 4 -- negative go down

            if e.flipH then
                punchbox  = world:spawn("punchbox", e.pos.x + e.move.vel.x * 2 - punshReach, e.pos.y + direction.y * 8 + boxHeight)
            else
                punchbox  = world:spawn("punchbox", e.pos.x + e.move.vel.x * 2 + punshReach, e.pos.y + direction.y * 8 + boxHeight)
            end
            punchbox.force  = e.punch.force * Vec2(direction.x, 1)
            punchbox.owner  = e
            punchbox.move   = e.move
            e.drawState     = "punch"
            sound.punch:play()
            e.punchSpriteCountdown = 7

            e.punch.cooldown = e.punch.cooldown_total

        elseif e.punch.cooldown > 0 then 
            e.punch.cooldown = math.max(0, e.punch.cooldown - 1)
        end
    end   
)




return InputSystems