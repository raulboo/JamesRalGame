local ENTITY_LABEL_TABLE = require"entities.ENTITY_LABEL_TABLE" 

local World = {}

-- Constructor, returns a new World table inheriting all the functions from this class (World)
function World.new() 
    return setmetatable({}, {
        __index=World
    })
end 

function World:spawn(label, spawn_point_or_x, y) 
    local spawn_point = y and Vec2(spawn_point_or_x,y) or Vec2(spawn_point_or_x.x, spawn_point_or_x.y)

    local new_entity = clone(require(ENTITY_LABEL_TABLE[label]))
    new_entity.pos = spawn_point
    table.insert(self, new_entity)

    return new_entity
end

return World