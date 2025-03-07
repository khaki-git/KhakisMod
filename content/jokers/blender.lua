local function mostCommonString(tbl)
    local counts = {}
    local maxCount = 0
    local mostCommon = nil
    for _, str in ipairs(tbl) do
      counts[str] = (counts[str] or 0) + 1
      if counts[str] > maxCount then
        maxCount = counts[str]
        mostCommon = str
      end
    end
    return mostCommon, maxCount
  end

SMODS.Joker({
    key = "blender",
    loc_txt = {name = "Blender", text = {"Convert all {C:attention}Played Cards", "to {C:attention}most played suit", "in {C:blue}Hand", "{C:attention}after scoring"}},
    atlas = "placeholders", pos = {x = 1, y = 0},
    rarity = 2,
    calculate = function(self, card, context)
        if context.after then
            local full_hand = context.full_hand
            local suits = {}

            for _,c in pairs(full_hand) do
                table.insert(suits, c.base.suit)
            end

            local top_suit = mostCommonString(suits) 
            
            for _,c in pairs(full_hand) do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() c:flip();play_sound('card1');c:juice_up(0.3, 0.3);return true end }))
            end

            for _,c in pairs(full_hand) do
                G.E_MANAGER:add_event(Event({
                    func = (function ()
                        c:change_suit(top_suit)
                        return true
                    end)
                }))
            end

            for _,c in pairs(full_hand) do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() c:flip();play_sound('card1');c:juice_up(0.3, 0.3);return true end }))
            end
            G.E_MANAGER:add_event(Event({trigger = "after", delay=1.3, func = function ()
                return true
            end}))
        end
    end
})