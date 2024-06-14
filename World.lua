local ENTITY_LABEL_TABLE = {}--require"entities/ENTITY_LABEL_TABLE.lua" 

local World = {}

function World.new() 
    return setmetatable({}, {
        __index=World
    })
end 

function World:spawn(label, x, y) 
    local new_entity = clone(ENTITY_LABEL_TABLE[label])
    new_entity.pos = Vec2(x,y)
    table.insert(self, new_entity)
end

return World