
tileTable = {}

function addTile(tileX, tileY, mapX, MapY)
    table.insert(tileTable,{
        x = mapX * TILE_SIZE,
        y = MapY * TILE_SIZE,
        quad = love.graphics.newQuad(( tileX * TILE_SIZE ), ( tileY * TILE_SIZE ), TILE_SIZE, TILE_SIZE, spriteSheet),
        cx1  = mapX,                                                  -- Collission: cx1 and cy1 are to left position
        cy1  = tileY,
        cx2  = mapX + TILE_SIZE,                                      -- cx2 is width of the collission box
        cy2  = tileY + TILE_SIZE,                                     -- cy2 height of the collission box

        update = function(self, dt)
            self.cx1 = self.x
            self.cy1 = self.y
            self.cx2 = self.x + TILE_SIZE
            self.cy2 = self.y + TILE_SIZE
        end,

        draw = function (self)
            love.graphics.draw(spriteSheet, self.quad, self.x, self.y)
        end,
    })
end