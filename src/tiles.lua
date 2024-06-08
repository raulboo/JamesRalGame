
tileTable = {}

function addTile(tileX, tileY, mapX, MapY)
    table.insert(tileTable,{
        position      = verctor2d(mapX * TILE_SIZE, MapY * TILE_SIZE),
        quad          = love.graphics.newQuad(( tileX * TILE_SIZE ), ( tileY * TILE_SIZE ), TILE_SIZE, TILE_SIZE, spriteSheet),
        cx1           = mapX,                                                  -- Collission: cx1 and cy1 are to left position
        cy1           = tileY,
        cx2           = mapX + TILE_SIZE,                                      -- cx2 is width of the collission box
        cy2           = tileY + TILE_SIZE,                                     -- cy2 height of the collission box
        collisionBox  = false,
        collisionTime = 0,


        update = function(self, dt)
            self.cx1 = self.position.x
            self.cy1 = self.position.y
            self.cx2 = self.position.x + TILE_SIZE
            self.cy2 = self.position.y + TILE_SIZE
        end,

        draw = function (self)
            love.graphics.draw(spriteSheet, self.quad, self.position.x, self.position.y)

            if self.collisionBox then
                love.graphics.rectangle("fill", self.cx1, self.cy1, TILE_SIZE, TILE_SIZE)
            end
            self.collisionTime = self.collisionTime - 1
            if self.collisionTime < 0 then
                self.collisionBox = false
                self.collisionTime = 2
            end
        end,
    })
end