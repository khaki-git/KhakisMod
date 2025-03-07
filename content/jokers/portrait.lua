SMODS.Joker({
    key = "portrait",
    loc_txt = {name = "Portrait", text = {"Played face cards give", "{X:mult,C:white}X#1#{} Mult"}},
    atlas = "placeholders", pos = {x = 2, y = 0},
    rarity = 3,
    config = { extra = {xmult = 1.5}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                return {
                    Xmult_mod = card.ability.extra.xmult,
                    message = "X"..card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})