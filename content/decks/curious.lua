local function weighted_random_choice(weighted_table, seed)
    local total_weight = 0
    for _, item in ipairs(weighted_table) do
        total_weight = total_weight + item.weight
    end

    local random_weight = pseudorandom(seed) * total_weight
    local cumulative_weight = 0

    for _, item in ipairs(weighted_table) do
        cumulative_weight = cumulative_weight + item.weight
        if random_weight < cumulative_weight then
            return item
        end
    end
end

SMODS.Back({
    key = "curious",
    loc_txt = {name = "Curious Deck", text = {
        "{C:blue}+1{} Hand each round",
        "{C:red}+2{} Discards each round",
        "Mult is replaced by either",
        "{C:attention}Addition, Subtraction, Multiplication",
        "{C:attention}Exponents, or Division",
        "Replacement changes","each hand and",
        "only reveals after","you press {C:blue}Play Hand",
        "{C:inactive}Some replacements are",
        "{C:inactive}more likely than others",
    }},
    atlas = "decks", pos = { x = 3, y = 0 },
    config = {hands = 1, discards = 2},
    apply = function(_, back)
        G.x_symbol = "?"
        G.C.UI_MULT_ALT = G.C.UI_QUESTION
    end,
    calculate = function(_, back, context)
        if context.before and not context.other_card then
            local reveals = {
                {symbol = "X", colour = G.C.UI_MULT, weight = 60},
                {symbol = "+", colour = G.C.UI_ADD, weight = 15},
                {symbol = "-", colour = G.C.UI_SUB, weight = 4},
                {symbol = "/", colour = G.C.UI_DIV, weight = 2},
                {symbol = "^", colour = G.C.UI_POW, weight = 4.5},
                {symbol = "^^", colour = G.C.BLACK, weight = 1},
            }
            local reveal
            repeat
                reveal = weighted_random_choice(reveals, "curious")
            until reveal.colour ~= G.C.UI_MULT_ALT
            G.x_symbol = reveal.symbol
            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_colour(G.C.UI_MULT_ALT, reveal.colour, 0.05)
                    return true
                end)
            }))
        end
    end
})
