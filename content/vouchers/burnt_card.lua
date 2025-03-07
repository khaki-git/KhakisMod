SMODS.Voucher({
    key = "burning_card",
    loc_txt = {name = "Burning Card", text = {"{C:attention}+1{} max card limit when using", "a Tarot Card"}},
    atlas = "vouchers", pos = {x = 1, y = 0},
    redeem = function(self, card)
        G.GAME.enhance_bonus = G.GAME.enhance_bonus + 1
    end
})

SMODS.Voucher({
    key = "burnt_card",
    loc_txt = {name = "Burnt Card", text = {"{C:attention}+1{} max card limit when using", "a Tarot Card"}},
    atlas = "vouchers", pos = {x = 2, y = 0},
    redeem = function(self, card)
        G.GAME.enhance_bonus = G.GAME.enhance_bonus + 1
    end,
    requires = {"v_kmod_burning_card"}
})