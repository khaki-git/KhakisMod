SMODS.Joker({
    key = "colourful_joker",
    loc_txt = {name = "Colourful Joker", text = {"{X:mult,C:white}X#1#{} Mult", "Gains {X:mult,C:white}X#2#{} when a changing a cards suit."}},
    atlas = "jokers", pos = {x = 2, y = 0},
    rarity = 2,
    config = { extra = {xmult = 1, scaling = 0.1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.scaling
            }
        }
    end,
    calculate = function(self, card, context)
        if context.change_suit then -- patched in context method (not in vanilla)
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.scaling

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "X" .. card.ability.extra.xmult, colour = G.C.MULT})
        end
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = "X" .. card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end
})