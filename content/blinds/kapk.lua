SMODS.Blind({
    atlas = "kmod_blinds", pos = {y = 1},
    key = "kapk",
    loc_txt = {name = "The Kapk", text = {"Cards lower", "or equal to 6", "in value are", "flipped"}},
    boss = {min = 1, max = 10},
    dollars = 5,
    mult = 2,
    boss_colour = HEX('8ABA58'),
    stay_flipped = function(self, area, card)
        if area == G.hand then
            if card.base.nominal <= 6 then
                return true
            end
        end
        return false
    end,
})