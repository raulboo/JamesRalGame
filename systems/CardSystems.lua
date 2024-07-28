require"ecs"

local CardSystems = {}


local _cards = {
    {
        display_name   = "Pulo Absurdo",
        callEffect     = function(e)
            e.jump.speed = e.jump.speed * 3
        end
    },
    {
        display_name   = "Todo mundo Gigante",
        callEffect     = function(e)
            e.aabb  = e.aabb * 3
            e.pos.y = e.pos.y - e.aabb.y/2
            e.scale = 3
            e.punch.force = e.punch.force * 3
        end
    },
    {
        display_name   = "Controles Invertidos",
        callEffect     = function(e)
            local original_controls = clone(e.controls)
            e.controls.walk_left  = original_controls.walk_right 
            e.controls.walk_right = original_controls.walk_left 
            e.controls.jump       = original_controls.down 
            e.controls.down       = original_controls.jump 
            e.controls.punch      = original_controls.special 
            e.controls.special    = original_controls.punch
        end
    }

}

-- todo: add pseudorandomness
local function _getNewCards()
    local first_card = math.random(#_cards)
    while (not second_card) or (second_card == first_card) do second_card = math.random(#_cards) end 
    while (not third_card) or (third_card == first_card) or (third_card == second_card) do third_card = math.random(#_cards) end 
    return {first_card, second_card, third_card}
end

local function _applyCardOfChoice(idx)
    local all_players = tableFilter(world, function(e) return e.type=="player" end)
    tableMap(all_players, _cards[idx].callEffect)
end

local _displayed_cards = nil

CardSystems.displayChoice = system({"scored"},
    function(e)
        -- choose 3 "random" cards
        if not _displayed_cards then
            _displayed_cards = _getNewCards()
        end

        -- display cards while player has "scored" attribute
        love.graphics.print("ESCOLHA, PLAYER "..e.player_idx, 200, 120)
        for i, card_idx in ipairs(_displayed_cards) do
            love.graphics.print("> ["..e.controls.cards[i].."] ".._cards[card_idx].display_name, 200, 120 + 16*i)
        end
        
        -- check if player has chosen and apply the chosen effect
        for j,key in ipairs(e.controls.cards) do
            if love.keyboard.isPressed(key) then
                _applyCardOfChoice(_displayed_cards[j])
                -- reset cards
                e.scored = nil
                _displayed_cards = nil
            end
        end
    end
)

return CardSystems
