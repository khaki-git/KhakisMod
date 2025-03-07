SMODS.Consumable({
    key = "infinity",
    set = "Spectral",
    loc_txt = {name = "Infinity", text = {"Add {C:attention}Eternal{} to the leftmost Joker."}},
    atlas = 'consumables', pos = { x = 2, y = 0 },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key='eternal', set='Other'}
    end,
    use = function(self, card, area, _)
        local other_card = G.jokers.cards[1]
        other_card:set_eternal(true)
        other_card:juice_up(0.6, 0.6)
    end,
    can_use = function(self, card)
        if #G.jokers.cards > 0 then
            return true
        end
        return false
    end
})

SMODS.Consumable({
    key = "Sacrifice",
    set = "Spectral",
    loc_txt = {name = "Sacrifice", text = {"Destroy all {C:attention}face cards", "held in hand", "Gain {C:gold}$#1#{} for each destroyed", "card"}},
    atlas = 'placeholders', pos = { x = 2, y = 2 },
    config = {extra = {money = 3}},
    cost = 3,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    use = function(self, card, area, _)
        local marked_for_death = 0
        for _,c in pairs(G.hand.cards) do
            if c:is_face() then
                marked_for_death = marked_for_death + 1
                G.E_MANAGER:add_event(Event({
                    delay = 0.15,
                    trigger = 'after',
                    func = (function ()
                        c:start_dissolve({ HEX("a463f0") }, nil, 1.6)
                        return true
                    end)
                }))
            end
        end

        local redeemed = marked_for_death * card.ability.extra.money

        ease_dollars(redeemed)
    end,
    can_use = function(self, card)
        return true
    end
})

SMODS.Consumable({
    key = "Slash",
    set = "Spectral",
    loc_txt = {name = "Slash", text = {"Add an {C:dark_edition}Edition{} to", "a random {C:attention}Joker{} and add", "a {C:attention}Sticker{} to the {C:attention}same Joker."}},
    atlas = 'placeholders', pos = { x = 2, y = 2 },
    cost = 3,
    use = function(self, card, area, _)
        G.E_MANAGER:add_event(Event({
            delay = 0.15,
            trigger = 'after',
            func = (function ()
                local edition = poll_edition("sword", nil, nil, true)

                local allowed = {}
                for _,j in pairs(G.jokers.cards) do
                    if not j.edition then
                        table.insert(allowed, j)
                    end
                end
                if #allowed > 0 then
                    local j = pseudorandom_element(allowed, pseudoseed("slashed"))
                    j:set_edition(edition)
                    j:juice_up(0.6)
                    play_sound('gold_seal', 1.2, 0.4)
                    local x = pseudorandom("slashv")
                    if x < 0.33 then
                        j:set_eternal(true)
                    elseif x < 0.66 then
                        j:set_rental(true)
                    else
                        j:set_perishable(true)
                    end
                    return true
                end
            end)
        }))
    end,
    can_use = function(self, card)
        local available = 0

        for _,j in pairs(G.jokers.cards) do
            if j.edition == nil then
                available = available + 1
            end
        end

        return available > 0
    end
})
