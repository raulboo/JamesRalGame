return {
    type    = "punchbox",
    type_id = 101,

    owner = nil,

    decay = 5,         --lives for 10 frames
    aabb = Vec2(16,8),
    force = nil,

    collision_effects = {
        -- when hitting a entity of type_id==1 (player), knockback
        [001] = function (self, e) 
            if e == self.owner then return end
            e.move.vel = e.move.vel + self.force
            e.hit_by_player_last = self.owner.player_idx
            sfx("hurt")
        end
    }
}