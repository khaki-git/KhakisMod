SMODS.Joker({
    key = "blackjack",
    loc_txt = {name = "Blackjack", text = {"{C:white,X:mult}X#1#{} Mult if scoring cards", "rank add up to #2#", "{C:inactive}(Aces count as 11){}"}},
    atlas = "jokers", pos = {x = 1, y = 0},
    config = { extra = {goal = 21, xmult = 2}},
    loc_vars = function(_, _, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.goal
            }
        }
    end,
    calculate = function(_, card, context)
        if context.joker_main then
            local value = 0
            for _,c in pairs(context.scoring_hand) do
                local val = -1
                pcall(function()
                    val = tonumber(c.base.value)
                end)

                if val == -1 or val == nil then
                    if c.base.value == "Ace" then
                        val = 11
                    else
                        val = 10
                    end
                end

                value = value + val
            end

            print(value)

            if value == card.ability.extra.goal then
                return {
                    message = "X" .. card.ability.extra.xmult,
                    colour = G.C.MULT,
                    Xmult_mod = card.ability.extra.xmult
                }
            end
        end
    end
})