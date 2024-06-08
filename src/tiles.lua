
tileTable = {}

function addTile(tileX, tileY, mapX, MapY)
    table.insert(tileTable,{
        position      = verctor2d(mapX * TILE_SIZE, MapY * TILE_SIZE),
        quad          = love.graphics.newQuad(( tileX * TILE_SIZE ), ( tileY * TILE_SIZE ), TILE_SIZE, TILE_SIZE, spriteSheet),
        collision     = rect(mapX, MapY, TILE_SIZE, TILE_SIZE),

        update = function(self, dt)
            self:collissionBoxes()
        end,

        draw = function (self)
            love.graphics.draw(spriteSheet, self.quad, self.position.x, self.position.y)
        end,

        collissionBoxes = function(self)
            self.collision.position.x = self.position.x
            self.collision.position.y = self.position.y
            self.collision.width      = TILE_SIZE
            self.collision.height     = TILE_SIZE
        end,
    })
end