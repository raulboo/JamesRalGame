---@diagnostic disable: trailing-space

-- Area for player controls code
-- prototype for  control scheme
player1 = {}

-- Player 1 controls
player1.right = "right"
player1.left  = "left"
player1.jump  = "space"
player1.speed = 64

function controls(dt)
    if love.keyboard.isDown( player1.right ) then 
        x = x + player1.speed * dt
    end
    if love.keyboard.isDown( player1.left ) then 
        x = x - player1.speed * dt
    end
end