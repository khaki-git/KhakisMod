SMODS.Joker({
    key = "obmij",
    loc_txt = {name = "obmiJ", text = {"{C:mult}-#1#{} Mult"}},
    atlas = "placeholders", pos = {x = 1, y = 0},
    config = { extra = {mult = 4}},
    rarity = "kmod_corrupt",
    loc_vars = function(_, _, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(_, card, context)
        if context.joker_main then
            if mult > to_big(card.ability.extra.mult) then
                return {
                    mult_mod = -card.ability.extra.mult,
                    message = "-4 Mult",
                    colour = G.C.MULT
                }
            end
        end
    end
})