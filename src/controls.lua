---@diagnostic disable: trailing-space

-- Area for player controls code
-- prototype for  control scheme
control1 = {}

-- Player 1 controls
control1.right = "right"
control1.left  = "left"
control1.down  = "down"
control1.up    = "up"
control1.jump  = "space"

function controls(dt)
    movement(dt, 1, control1)
end

function movement(dt, player, control)
    if love.keyboard.isDown( control.right ) then 
        playerTable[player].x = playerTable[player].x + playerTable[player].speed * dt
    end

    if love.keyboard.isDown( control.left ) then 
        playerTable[player].x = playerTable[player].x - playerTable[player].speed * dt
    end

    if love.keyboard.isDown( control.down ) then 
        playerTable[player].y = playerTable[player].y + playerTable[player].speed * dt
    end
    
    if love.keyboard.isDown( control.up ) then 
        playerTable[player].y = playerTable[player].y - playerTable[player].speed * dt
    end
end