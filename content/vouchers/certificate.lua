SMODS.Voucher({
    key = "certificate",
    loc_txt = {name = "Certificate", text = {"{C:voucher}+1 Voucher Slot{} in the {C:attention}Shop"}},
    atlas = "vouchers", pos = {x = 0, y = 1},
    calculate = function(self, card, ctx) 
        if ctx.starting_shop then
            G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
            local voucher_key = get_next_voucher_key(true)
            G.ARGS.voucher_tag[voucher_key] = true
            G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
            local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
            G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[voucher_key],{bypass_discovery_center = true, bypass_discovery_ui = true})
            card.from_tag = true
            create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
            card:start_materialize()
            G.shop_vouchers:emplace(card)
        end
    end
})

SMODS.Voucher({
    key = "trio",
    loc_txt = {name = "Trio", text = {"{C:voucher}+1 Voucher Slot{} in the {C:attention}Shop"}},
    atlas = "vouchers", pos = {x = 1, y = 1},
    calculate = function(self, card, ctx) 
        if ctx.starting_shop then
            G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
            local voucher_key = get_next_voucher_key(true)
            G.ARGS.voucher_tag[voucher_key] = true
            G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
            local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
            G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[voucher_key],{bypass_discovery_center = true, bypass_discovery_ui = true})
            card.from_tag = true
            create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
            card:start_materialize()
            G.shop_vouchers:emplace(card)
        end
    end,
    requires = {"v_kmod_certificate"}
})