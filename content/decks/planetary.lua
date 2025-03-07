SMODS.Back({
    key = "planetary",
    loc_txt = {name = "Planetary Deck", text = {
        "{C:blue}Planet cards{} level",
        "up hands by an extra",
        "{C:attention}2 levels{}"
    }},
    atlas = "decks", pos = { x = 2, y = 0 },
    apply = function(_, _)
        G.GAME.level_mult = G.GAME.level_mult + 2
    end
})