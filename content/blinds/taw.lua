SMODS.Blind({
    atlas = "kmod_blinds", pos = {y = 2},
    key = "taw",
    loc_txt = {name = "The Taw", text = {"{C:chip}Mult{} cannot be", "higher than {C:mult}Chips"}},
    boss = {min = 1, max = 15},
    dollars = 5,
    mult = 2,
    boss_colour = HEX('6E008D'),
    calculate = function(self, blind, context)
        if context.final_scoring_step then
            if mult > hand_chips then
                return {
                    card = blind,
                    scored_card = blind,
                    mult_mod = -(mult-hand_chips)
                }
            end
        end
    end,
})