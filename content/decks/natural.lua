SMODS.Back({
    key = "natural_selection",
    loc_txt = {name = "Natural Selection Deck", text = {
        "At end of round,",
        "{C:red}destroy{} 1-3 cards that are",
        "in the {C:attention}lowest 50% rank{}",
    }},
    atlas = "decks", pos = { x = 1, y = 0 },
    config = {extra = {}},
    calculate = function(_, back, context)
        if context.end_of_round and not context.other_card then
            local median = 0
            local cards = #G.deck.cards

            for _,card in pairs(G.deck.cards) do
                local val = -1
                pcall(function()
                    val = tonumber(card.base.value)
                end)

                if val == -1 or val == nil then
                    if card.base.value == "Ace" then
                        val = 11
                    else
                        val = 10
                    end
                end
                median = median + val
            end

            median = median / cards

            local lowest = {}
            for _,card in pairs(G.deck.cards) do
                local val = -1
                pcall(function()
                    val = tonumber(card.base.value)
                end)

                if val == -1 or val == nil then
                    if card.base.value == "Ace" then
                        val = 11
                    else
                        val = 10
                    end
                end

                if val <= median then
                    table.insert(lowest, card)
                end
            end

            local victims = 0
            for _ = 1, math.floor(pseudorandom("naturalselection")*3)+1 do
                if #lowest <= 0 then
                    break
                end
                local card = lowest[math.clamp(math.floor(pseudorandom("naturalselection")*#lowest), 1, #lowest-1)]

                card:juice_up(0.8, 0.8)
                card:start_dissolve({ HEX("63f06b") }, nil, 1.6)
                victims = victims + 1

                table.remove(lowest, table.find(lowest, card))
            end
            play_sound("tarot1", 0.96 + math.random() * 0.08)

            return {
                message = "Killed " .. tostring(victims) .. "!",
                colour = G.C.YELLOW
            }
        end
    end
})