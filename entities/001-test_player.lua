return {
    type       = "player",
    type_id    = 001,
    player_idx = nil,

    pos       = nil,
    sprite    = 64,
    drawState = "grounded",
    punchSpriteCountdown = 0,
    flipH  = false,
    scale  = 1,

    hit_by_player_last = nil, 

    grav = 0.2,

    move = { 
        vel       = Vec2(0, 0),
        min_vel   = Vec2(-3,-10), --upwards, leftwards
        max_vel	  = Vec2( 3, 5), --downwards, rightwards
        remainder = Vec2(0, 0),
    },

    -- axis-aligned bounding-box (hitbox size, centered on e.pos)
    aabb = Vec2(16, 16),

    walk = {
        accel = 40,
    },
    jump = {
        speed = 300,
    },
    punch = {
        force = Vec2(16, -1),
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
        down       = "down",
        punch      = ",",
        special    = ".",
        cards      = {"8","9","0"}
    }
}