---@diagnostic disable: undefined-global

local keyStates = {}

love.keyboard.isPressed = function(k)
    love.keyboard.resetKeyStates()
    local now = love.keyboard.isDown(k)
    if keyStates[k] then
        local last = keyStates[k].last
        keyStates[k].now = now
        return now and not last
    else
        keyStates[k] = {now = now, last = false}
        return now
    end
end

love.keyboard.isReleased = function(k)
    local now = love.keyboard.isDown(k)
    if keyStates[k] then
        local last = keyStates[k].last
        keyStates[k].now = now
        return not now and last
    else
        keyStates[k] = {now = now, last = false}
        return now
    end
end

love.keyboard.resetKeyStates = function()
    for k, _ in pairs(keyStates) do
        keyStates[k].last = keyStates[k].now
    end
end 