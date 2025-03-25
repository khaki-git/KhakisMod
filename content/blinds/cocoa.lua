SMODS.Blind({
    atlas = "kmod_blinds", pos = {y = 4},
    key = "cocoa_ladder",
    loc_txt = {name = "Cocoa Ladder", text = {"Previously debuffed cards", "are debuffed."}},
    boss = {showdown = true},
    dollars = 8,
    mult = 2,
    boss_colour = HEX('8B6937'),
    calculate = function(self, blind, context)
        if context.debuff_card then
            local c = context.debuff_card

            if c.kmod_debuffed then -- cocoa.toml for patch
                return {debuff = true, card = blind, scored_card = blind}
            end
        end
    end,
})