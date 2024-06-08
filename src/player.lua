---@diagnostic disable: undefined-global, lowercase-global

-- Area for player entity code

playerTable = {}

function addPlayer(x, y)
    table.insert(playerTable, {
        position  = verctor2d(x, y),
        velocity  = verctor2d(0, 0),
        flipH     = false,
        grounded  = false,
        quad      = love.graphics.newQuad(0, 16, 16, 16, spriteSheet),  -- individual quad to draw the player
        speed     = 100,                                                -- Character move speed
        jump      = 350,                                                -- Jump force
        collision = rect(x, y, x + TILE_SIZE, y + TILE_SIZE),

        update = function(self, dt)
            self:physics()
            self:collissionBoxes()
        end,

        draw = function(self)
            local fh
            local hOffset
            if self.flipH then
                fh = -1
                hOffset = TILE_SIZE
            else
                fh = 1
                hOffset = 0
            end

            love.graphics.draw(spriteSheet, self.quad, self.position.x, self.position.y, 0, fh, 1, hOffset)

            -- Draw collission box
            --love.graphics.rectangle("line", self.cx1, self.cy1, TILE_SIZE, TILE_SIZE)
        end,

        collissionBoxes = function(self)
            self.collision.position.x = self.position.x
            self.collision.position.y = self.position.y
            self.collision.width      = self.collision.position.x + TILE_SIZE
            self.collision.height     = self.collision.position.y + TILE_SIZE
        end,

        physics = function(self)
            self.velocity.y = self.velocity.y + Gravity
            self.position.y  = self.position.y + self.velocity.y
        end,
    })
end