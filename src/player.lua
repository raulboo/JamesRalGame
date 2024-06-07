---@diagnostic disable: undefined-global, lowercase-global

-- Area for player entity code

playerTable = {}

function addPlayer(x, y)
    table.insert(playerTable, {
        x        = x or 0,                                             -- position x
        y        = y or 0,                                             -- position y
        dx       = 0,                                                  -- Horizontal velocity
        grounded = false,
        dy       = 0,                                                  -- Vertical Velocity
        quad     = love.graphics.newQuad(0, 16, 16, 16, spriteSheet),  -- individual quad to draw the player
        speed    = 100,                                                -- Character move speed
        jump     = 400,                                                -- Jump force
        
        cx1      = x,                                                  -- Collission: cx1 and cy1 are to left position
        cy1      = y,
        cx2      = x + TILE_SIZE,                                      -- cx2 is width of the collission box
        cy2      = y + TILE_SIZE,                                      -- cy2 height of the collission box

        update = function(self, dt)
            self:physics()
            self:collissionBoxes()
        end,

        draw = function(self)
            love.graphics.draw(spriteSheet, self.quad, self.x, self.y)

            --love.graphics.rectangle("line", self.cx1, self.cy1, TILE_SIZE, TILE_SIZE)
        end,

        collissionBoxes = function(self)
            self.cx1 = self.x
            self.cy1 = self.y
            self.cx2 = self.x + TILE_SIZE
            self.cy2 = self.y + TILE_SIZE
        end,

        physics = function(self)
            self.dy = self.dy + Gravity
            self.y  = self.y + self.dy
        end,
    })
end