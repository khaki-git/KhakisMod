SMODS.Joker({
    key = "broken_mirror",
    loc_txt = {name = "Broken Mirror", text = {"{C:attention}Copies the ability{} of the", "card to the {C:attention}left", "{C:green}1 in #1#{} chance to", "destroy this card at {C:attention}end of round"}},
    atlas = "placeholders", pos = {x = 1, y = 0},
    config = { extra = {odds = 6}},
    rarity = 2,
    loc_vars = function(_, _, card)
        return {
            vars = {
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(_, card, context)
        if context.end_of_round and not context.other_card then
            if pseudorandom("broken_mirror") < 1/card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    delay = 1,
                    func = function ()
                        card:shatter()
                        return true
                    end
                }))
                G.GAME.mirror_broke = true
                return {
                    colour = G.C.CHIPS,
                    message = "Shattered!",
                }
            end
        end
        local pre = nil
        local should = false

        for _,j in pairs(G.jokers.cards) do
            if j.ID == card.ID then
                break
            end
            pre = j
        end

        if pre ~= nil then
            local ret = SMODS.blueprint_effect(card, pre, context)
            if ret then should = true SMODS.calculate_effect(ret, card) end
        end
        if should then return {} end
    end
})