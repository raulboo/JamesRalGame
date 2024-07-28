local LifeSystems = {}

LifeSystems.deathOutsideBoudaries = system({"pos", "aabb"},
    function (e)
        if stage:isSolidInArea(e.pos, e.aabb)==nil then e.die = true end
    end
)

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
        if e.hit_by_player_last then 
            local scored_player = nil
            for _,s in pairs(world) do if s.player_idx == e.hit_by_player_last then scored_player = s end end 
            scored_player.scored = true
        end
        world:remove(e)
    end
)

LifeSystems.respawn = system({"controls","die"},
    function (e)
        local new_player = world:spawn(e, pickRandom(stage.respawn_points))
        new_player.move.vel           = Vec2(0,0)
        new_player.hit_by_player_last = nil
        new_player.die                = false
    end
)

return LifeSystems