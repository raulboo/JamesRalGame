local ENTITY_LABEL_TABLE = require"entities.ENTITY_LABEL_TABLE" 

local World = {}

local _uuid = 0

-- Constructor, returns a new World table inheriting all the functions from this class (World)
function World.new() 
    return setmetatable({}, {
        __index=World
    })
end 

function World:spawn(label, spawn_point_or_x, y) 
    local spawn_point = y and Vec2(spawn_point_or_x,y) or Vec2(spawn_point_or_x.x, spawn_point_or_x.y)

    local new_entity = clone(require(ENTITY_LABEL_TABLE[label]))
    new_entity.pos  = spawn_point
    new_entity.uuid = _uuid 
    _uuid = _uuid + 1
    -- uuid = universal unique identifier (always diferent for each entity)
    self[new_entity.uuid] = new_entity

    return new_entity
end

function World:remove(entity)
    self[entity.uuid] = nil
end

return World