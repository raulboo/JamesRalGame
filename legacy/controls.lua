---@diagnostic disable: trailing-space, lowercase-global, undefined-global

-- Area for player controls code
-- prototype for  control scheme

-- Player 1 controls
control1 = {}
control1.right = "right"
control1.left  = "left"
control1.jump  = "space"

-- Player 1 controls
control2 = {}
control2.right = "d"
control2.left  = "a"
control2.jump  = "e"

function controls(dt)
    movement(dt, 1, control1)
    movement(dt, 2, control2)
end

function movement(dt, player_idx, control)
    p = playerTable[player_idx] -- Current Player

    if love.keyboard.isDown(control.right) then 
        p.position.x = p.position.x + p.speed * dt
        p.flipH = false
    end

    if love.keyboard.isDown( control.left ) then 
        p.position.x = p.position.x - p.speed * dt
        p.flipH = true
    end

    if love.keyboard.isDown( control.jump ) and p.grounded == true then 
        p.velocity.y = p.velocity.y - p.jump * dt
        p.grounded = false
    end
end