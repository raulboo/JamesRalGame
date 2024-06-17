local DebugSystems = {}

-- untested, just a sketch
DebugSystems.displayAllAabb = system({"pos","aabb"},
    function (e)
        local top_left = e.pos - (e.aabb*0.5)
        love.graphics.rectangle("line",top_left.x, top_left.y, e.aabb.x, e.aabb.y)
    end
)

DebugSystems.addEntityInfoToDebugWindow = system({},
    function (e)
        -- todo
    end
)

return DebugSystems