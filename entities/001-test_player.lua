return {
    type    = "player",
    type_id = 001,

    pos       = nil,
    sprite    = 64,
    drawState = "grounded",
    punchSpriteCountdown = 0,
    flipH  = false,

    grav = 0.2,

    move = { 
        vel       = Vec2(0, 0),
        max_vel	  = Vec2(3, 5),
        remainder = Vec2(0, 0),
    },

    -- axis-aligned bounding-box (hitbox size, centered on e.pos)
    aabb = Vec2(16,16),

    walk = {
        accel = 40,
    },
    jump = {
        speed = 300,
    },
    punch = {
        force = Vec2(16,-1),
        cooldown_total = 5,
        cooldown = 0,
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