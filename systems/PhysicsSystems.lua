require"ecs"
require"utilities"

local PhysicsSystems = {}
-- /systems/PhysicsSystems.lua -> moveActorX(), moveActorY(), pullGravity()


PhysicsSystems.moveActorX = system({"pos", "move", "aabb"},
    function(e)    
        e.move.vel.x = mid(-e.move.max_vel.x, e.move.vel.x, e.move.max_vel.x)

        local dx = round(e.move.vel.x)

        while dx~=0 do
            -- moving left
            if dx < 0 then
                -- colliding left 
                if stage:isSolidInArea(e.pos - Vec2(1,0), e.aabb) then 
                    e.move.vel.x = 0
                    dx = 0
                else
                    e.pos.x = e.pos.x - 1
                    dx = dx + 1
                end

            -- moving right
            elseif dx > 0 then
                -- colliding right 
                if stage:isSolidInArea(e.pos + Vec2(1,0), e.aabb) then 
                    e.move.vel.x = 0
                    dx = 0
                else
                    e.pos.x = e.pos.x + 1
                    dx = dx - 1
                end
            end

        end
    end
)

PhysicsSystems.moveActorY = system({"pos", "move", "aabb"},
    function(e)
        e.move.vel.y = mid(-e.move.max_vel.y, e.move.vel.y, e.move.max_vel.y)

        local dy = round(e.move.vel.y)

        while dy~=0 do
            --print(dy)
            -- moving up
            if dy < 0 then
                -- colliding up 
                if stage:isSolidInArea(e.pos - Vec2(0,1), e.aabb) then 
                    e.move.vel.y = 0
                    dy = 0
                else
                    e.pos.y = e.pos.y - 1
                    dy = dy + 1
                end

            -- moving down
            elseif dy > 0 then
                -- colliding down 
                if stage:isSolidInArea(e.pos + Vec2(0,1), e.aabb) then 
                    e.move.vel.y = 0
                    dy = 0
                    e.grounded = true
                else
                    e.pos.y = e.pos.y + 1
                    dy = dy - 1
                    e.grounded = nil
                end
            end

        end
    end
)

PhysicsSystems.pullGravity = system({"pos","move","grav"},
    function(e)
        e.move.vel.y = e.move.vel.y + e.grav
    end
)

PhysicsSystems.applyFriction = system({"move", "grounded", "friction"},
    function(e)
        e.move.vel.x = e.move.vel.x * e.friction.grounded
    end
)

return PhysicsSystems