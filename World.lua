local ENTITY_LABEL_TABLE = require"entities.ENTITY_LABEL_TABLE" 

local World = {}

local _uuid = 0

-- Constructor, returns a new World table inheriting all the functions from this class (World)
function World.new() 
    return setmetatable({}, {
        __index=World
    })
end 

function World:spawn(label_or_prototype, spawn_point_or_x, y) 
    local spawn_point   = y and Vec2(spawn_point_or_x,y) or Vec2(spawn_point_or_x.x, spawn_point_or_x.y)
    local is_label_mode = (type(label_or_prototype)=="string")

    local new_entity = is_label_mode and clone(require(ENTITY_LABEL_TABLE[label_or_prototype])) or clone(label_or_prototype)
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