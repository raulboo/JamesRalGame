---@diagnostic disable: undefined-global, lowercase-global

-- Area for player entity code

playerTable = {}

function addPlayer(x, y)
    table.insert(playerTable, {
        x     = x or 0,                                             -- position x
        y     = y or 0,                                             -- position y
        dx    = 0,                                                  -- Horizontal velocity
        dy    = 0,                                                  -- Vertical Velocity
        quad  = love.graphics.newQuad(0, 16, 16, 16, spriteSheet),  -- individual quad to draw the player
        speed = 100,                                                -- Character move speed
        
        cx1,                                                        -- Collission: cx1 and cy1 are to left position
        cy1,
        cx2,                                                        -- cx2 is width of the collission box
        cy2,                                                        -- cy2 height of the collission box

        update = function(self, dt)
            self:collissionBoxes()
        end,

        draw = function(self)
            love.graphics.draw(spriteSheet, self.quad, self.x, self.y)
        end,

        collissionBoxes = function(self)
            self.cx1 = self.x
            self.cy1 = self.y
            self.cx2 = self.x + 15
            self.cy2 = self.y + 15
        end,
    })
end 