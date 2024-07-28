require"ecs"

local CardSystems = {}


local _cards = {
    {
        display_name   = "Pulo Absurdo",
        callEffect     = function(e)
            e.jump.speed = e.jump.speed * 5
        end
    }
}

-- todo: add pseudorandomness
local function _getNewCards()
    local first_card = math.random(#_cards)
    --while (not second_card) or (second_card == first_card) then second_card = math.random(#_cards) end 
    --while (not third_card) or (third_card == first_card) or (third_card == second_card) then third_card = math.random(#_cards) end 
    return {first_card}--, second_card, third_card}
end

local function _applyCardOfChoice(idx)
    local all_players = tableFilter(world, function(e) return e.type=="player" end)
    tableMap(all_players, _cards[idx].callEffect)

    for _,v in pairs(world) do assert(v.jump.speed==1500) end
    --[[
    for _,v in pairs(world) do
        if v.type == "player" then
            assert(false)
            _cards[idx].callEffect(v)
            assert(v.jump.speed == 1500)
        end
    end
    ]]--
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
