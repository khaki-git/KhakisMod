SMODS.Consumable({
    key = "light",
    set = "Tarot",
    loc_txt = {name = "The Light", text = {"{C:attention}The Hermit{} & {C:attention}Economy Tag{}", "have their max values doubled.", "{C:inactive}(20>40>60, not 20>40>80){}"}},
    atlas = 'consumables', pos = { x = 0, y = 0 },
    config = {extra = {mult = 1}},
    cost = 3,
    use = function(self, card, area, _)
        G.GAME.investment_mult = G.GAME.investment_mult + card.ability.extra.mult
        G.E_MANAGER:add_event(Event({
            func = (function()
                play_sound('timpani', 0.9 + math.random()*0.1, 0.8)
                return true
            end)
        }))
        return {
            message = "X" .. G.GAME.investment_mult,
            colour = G.C.FILTER
        }
    end,
    can_use = function(self, card)
        return true
    end
})