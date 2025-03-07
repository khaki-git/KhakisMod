SMODS.Joker({
    key = "ancient_curse",
    loc_txt = {name = "Ancient Curse", text = {"{X:mult,C:white}X#1#{} Mult when a #2#",
                                                "suit card is {C:attention}scored{}",
                                                "Loses {X:mult,C:white}X#3#{} Mult when",
                                                "looking at the {C:attention}tooltip{}",
                                                "{C:inactive}(Suit changes at end of round){}"}},
    atlas = "jokers", pos = {x = 0, y = 0},
    config = { extra = {xmult = 2.5, lost = 1/4, suit = "???"}},
    loc_vars = function(self, info_queue, card)
        if G.GAME.blind then
            card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.lost
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = "-" .. tostring(card.ability.extra.lost),
                colour = G.C.MULT,
            })
        end

        if card.ability.extra.xmult <= 1 then
            card:juice_up(0.6, 0.6)
            card:start_dissolve({ HEX("63f06b") }, nil, 1.6)
        end

        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.suit,
                card.ability.extra.lost,
                card.ability.extra.natural
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local suits = {
            }

            for _,pcard in pairs(G.deck.cards) do
                table.insert(suits, pcard.base.suit)
            end

            card.ability.extra.suit = suits[math.clamp(math.floor(pseudorandom("ancient_curse")*#suits+0.5), 1, #suits)]

            return {
                message = "Switched!",
                colour = G.C.FILTER
            }
        end

        if context.end_of_round and not context.other_card then
            if card.ability.extra.xmult <= 1 then
                card:juice_up(0.6, 0.6)
                card:start_dissolve({ HEX("63f06b") }, nil, 1.6)
            end
        end

        if context.individual and context.cardarea == G.play then
            local c = context.other_card

            if c.base.suit == card.ability.extra.suit then
                return {
                    message = "X" .. card.ability.extra.xmult,
                    colour = G.C.MULT,
                    Xmult_mod = card.ability.extra.xmult
                }
            end
        end
    end
})