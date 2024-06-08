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

function movement(dt, player, control)
    if love.keyboard.isDown( control.right ) then 
        playerTable[player].position.x = playerTable[player].position.x + playerTable[player].speed * dt
        playerTable[player].flipH = false
    end

    if love.keyboard.isDown( control.left ) then 
        playerTable[player].position.x = playerTable[player].position.x - playerTable[player].speed * dt
        playerTable[player].flipH = true
    end

    if love.keyboard.isDown( control.jump ) and playerTable[player].grounded == true then 
        playerTable[player].velocity.y = playerTable[player].velocity.y - playerTable[player].jump * dt
        playerTable[player].grounded = false
    end
end