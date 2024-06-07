TILE_SIZE = 16

tileTable = {}

function addTile(tile, mapX, MapY)
    table.insert(tileTable,{
        tile = tile,
        mapX = mapX * TILE_SIZE,
        MapY = MapY * TILE_SIZE,
        quad = love.graphics.newQuad(0, 0, TILE_SIZE, TILE_SIZE, spriteSheet),

        update = function(self, dt)

        end,

        draw = function (self)
            love.graphics.draw(spriteSheet, self.quad, self.mapX, self.MapY)
        end,
    })
end