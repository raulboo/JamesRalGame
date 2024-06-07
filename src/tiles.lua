
tileTable = {}

function addTile(tileX, tileY, mapX, MapY)
    table.insert(tileTable,{
        mapX = mapX * TILE_SIZE,
        MapY = MapY * TILE_SIZE,
        quad = love.graphics.newQuad(( tileX * TILE_SIZE ), ( tileY * TILE_SIZE ), TILE_SIZE, TILE_SIZE, spriteSheet),
        cx1,
        cy1,
        cx2,
        cy2,

        update = function(self, dt)
            self.cx1 = self.mapX
            self.cy1 = self.MapY
            self.cx2 = self.mapX + TILE_SIZE
            self.cy2 = self.MapY + TILE_SIZE
        end,

        draw = function (self)
            love.graphics.draw(spriteSheet, self.quad, self.mapX, self.MapY)
        end,
    })
end