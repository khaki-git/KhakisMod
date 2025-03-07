SMODS.PokerHand({
    key = "blackjack",
    mult = 3,
    chips = 30,
    l_mult = 2, l_chips = 30,
    loc_txt = {name = "Blackjack", description = {"Cards rank adds up to 21", "Will not count as 21 if cards are any more", "than 21"}},
    example = {
        { 'S_Q', true },
        { 'H_A', true }
    },
    evaluate = function(_, hand)
        local goal = 21
        local value = 0

        for _,c in pairs(hand) do
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
        if value == goal then
            return {hand}
        end
        return {}
    end
})