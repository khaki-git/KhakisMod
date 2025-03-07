SMODS.Blind({
    atlas = "kmod_blinds", pos = {y = 0},
    key = "saffron_jade",
    loc_txt = {name = "Saffron Jade", text = {"Cards have a 7 in 8 chance", "of being flipped."}},
    boss = {max = 16, showdown = true},
    dollars = 5,
    mult = 2,
    boss_colour = HEX('ED673D'),
    stay_flipped = function(self, area, card)
        if area == G.hand then
            if pseudorandom("saffron_jade") < 7/8 then
                return true
            end
        end
        return false
    end,
})