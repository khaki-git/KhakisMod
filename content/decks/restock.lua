SMODS.Back({
    key = "restock",
    loc_txt = {name = "Restock Deck", text = {
        "{C:blue}Hands{} & {C:red}Discards{} only",
        "restock at end of {C:attention}Ante{}",
        "{X:chips,C:white}X2.5{} {C:blue}Hands{} and {X:mult,C:white}X2.5{} {C:red}Discards{}",
        "-3 {C:blue}Hands{} & -2 {C:red}Discard{} when",
        "skipping a blind"
    }},
    atlas = "decks", pos = { x = 0, y = 0 },
    config = {extra = {hands = 0, discards = 0, boss = true, restock = 2.5, hand_loss = 3, discard_loss = 2}},
    calculate = function(_, back, context)
        local cfg = back.effect.config.extra
        if context.end_of_round then
            cfg.discards = G.GAME.current_round.discards_left
            cfg.hands = G.GAME.current_round.hands_left
        end

        if context.skip_blind then
            if cfg.boss then
                cfg.discards = math.floor(G.GAME.current_round.discards_left * back.effect.config.extra.restock)
                cfg.hands = math.floor(G.GAME.current_round.hands_left * back.effect.config.extra.restock)
                cfg.boss = false
            end
            cfg.hands = math.clamp(cfg.hands - back.effect.config.extra.hand_loss, 1, math.huge)
            cfg.discards = math.clamp(cfg.discards - back.effect.config.extra.discard_loss, 1, math.huge)

            return {
                colour = G.C.RED,
                message = "Taxed!"
            }
        end

        if context.setting_blind then
            if cfg.boss == true then
                G.GAME.current_round.discards_left = math.floor(G.GAME.current_round.discards_left * back.effect.config.extra.restock)
                G.GAME.current_round.hands_left = math.floor(G.GAME.current_round.hands_left * back.effect.config.extra.restock)
                cfg.boss = false
            else
                G.GAME.current_round.discards_left = back.effect.config.extra.discards
                G.GAME.current_round.hands_left = cfg.hands
            end

            if G.GAME.blind.boss then
                cfg.boss = true
            else
                cfg.boss = false
            end
        end
    end
})