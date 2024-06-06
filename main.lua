---@diagnostic disable: undefined-global

love.graphics.setDefaultFilter("nearest", "nearest")
canvas = love.graphics.newCanvas(480, 270)

function love.load() 
    james = love.graphics.newImage("james.png")

    print("aaaaaaa")
    x = 50
    y = 50
    speed = 200

    love.graphics.setDefaultFilter("nearest", "nearest")

end

function love.update(dt)
    if love.keyboard.isDown("right") then x = x + speed * dt end
    if love.keyboard.isDown("left")  then x = x - speed * dt end
    if love.keyboard.isDown("up")    then y = y - speed * dt end
    if love.keyboard.isDown("down")  then y = y + speed * dt end
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0.5, 0, 1) -- Background color
    
    love.graphics.setColor(255,0,0)
    --love.graphics.rectangle("fill", x, y, 50, 50)
    x = x + math.sin(x)
    love.graphics.setColor(1,1,1, 1)
    love.graphics.draw(james, x, y, 0, 4, 4)

    love.graphics.setCanvas()
    local maxScaleX = love.graphics.getWidth() / canvas:getWidth()
    local maxScaleY = love.graphics.getHeight() / canvas:getHeight()
    local scale = math.min(maxScaleX, maxScaleY)
    love.graphics.draw(canvas, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, scale, scale, canvas:getWidth() / 2, canvas:getHeight() / 2)
end

