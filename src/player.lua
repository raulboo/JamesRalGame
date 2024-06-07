---@diagnostic disable: undefined-global, lowercase-global

-- Area for player entity code

playerTable = {}

function addPlayer(x, y)
    table.insert(playerTable, {
        x      = x or 0,                                     -- position x
        y      = y or 0,                                     -- position y
        quad   = love.graphics.newQuad(0, 16, 16, 16, img),  -- individual quad to draw the player
        speed  = 100,

        cx1    = x,                                          -- Collission: cx1 and cy1 are to left position
        cy1    = y,
        cx2    = x + 16,                                     -- cx2 is width of the collission box
        cy2    = y + 16,                                     -- cy2 height of the collission box

        draw = function(self)
            love.graphics.draw(img, self.quad, self.x, self.y)
        end,

        update = function(self, dt)
            self.cx1 = self.x
            self.cy1 = self.y
            self.cx2 = self.x + 16
            self.cy2 = self.y + 16
        end,
    })
end 