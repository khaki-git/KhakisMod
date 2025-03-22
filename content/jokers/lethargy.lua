SMODS.Joker({
    key = "lethargy",
    loc_txt = {name = "Lethargy", text = {"{C:mult}Remove{} an {C:dark_edition}Edition{} from", "a random {C:attention}Joker Card{}", "at the {C:attention}end of round"}},
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
        if context.end_of_round and not context.other_card then
            local has_edition = {}

            for _,c in pairs(G.jokers.cards) do
                local edition_t = c.edition
                if edition_t then
                    table.insert(has_edition, c)
                end
            end

            if #has_edition > 0 then
                local negative = pseudorandom_element(has_edition, pseudohash("bad_apple"))
                negative:set_edition(nil)
                return {
                    message = "Clean!",
                    colour = G.C.BLACK
                }
            end
        end
    end
})