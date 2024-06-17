local LifeSystems = {}

LifeSystems.decay = system({"decay"},
    function (e)
        e.decay = e.decay - 1 
        if e.decay == 0 then
            e.decay = nil 
            e.die = true
        end
    end
)

LifeSystems.die = system({"die"},
    function (e)
        table.remove(world, e)
    end
)

return LifeSystems