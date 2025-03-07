SMODS.Joker({
    key = "jackpot",
    loc_txt = {name = "Jackpot", text = {"Doubles money if scoring hand", "contains a {C:attention}Three of a Kind", "of 7s", "{C:inactive}(Max of $#1#)"}},
    atlas = "placeholders", pos = {x = 1, y = 0},
    rarity = 2,
    config = {extra = {max_money = 15}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.max_money*G.GAME.investment_mult}}
    end,
    calculate = function(self, card, context)
        if context.after then
            local sevens = 0
            for _,c in pairs(G.play.cards) do
                if tonumber(c.base.nominal) == 7 then
                    sevens = sevens + 1
                end
            end
            if sevens >= 3 then
                return {
                    dollars = math.clamp(to_number(to_big(G.GAME.dollars)), 1, card.ability.extra.max_money*G.GAME.investment_mult),
                    colour = G.C.GOLD,
                    message = "Jackpot!"
                }
            end
        end
    end
})