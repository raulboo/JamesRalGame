return {
    type   = "player",
    pos    = nil,
    sprite = 64,

    grav = 0.2,

    move = { 
        vel       = Vec2(0,0),
        max_vel	  = Vec2(3,5),
        remainder = Vec2(0,0),
    },

    -- axis-aligned bounding-box (hitbox size, centered on e.pos)
    aabb = Vec2(16,16),

    walk = {
        accel = 1,
    },
    jump = {
        speed = 30,
    },

    friction = {
        grounded = 0.8
    },

    controls = {
        walk_left  = "left",
        walk_right = "right",
        jump       = "up",
        punch      = ",",
        special    = "."
    }
}