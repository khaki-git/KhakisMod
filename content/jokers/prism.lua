SMODS.Joker({
    key = "prism",
    loc_txt = {name = "Prism", text = {"{C:attention}Copies the ability{} of the {C:attention}Joker", "to the {C:attention}left and right{} of this card", "{C:inactive}Cannot copy duplicates of Prism"}},
    atlas = "placeholders", pos = {x = 0, y = 0},
    config = { extra = {odds = 6}},
    rarity = 1,
    loc_vars = function(_, _, card)
        return {
            vars = {
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(_, card, context)
        local pre = nil
        local after = nil
        for _,j in pairs(G.jokers.cards) do
            if j.ID == card.ID then
                after = G.jokers.cards[_+1]
                break
            end
            pre = j
        end

        if pre and (pre.config.center_key == "j_kmod_prism" or pre.config.center_key == "j_kmod_broken_mirror") then
            G.E_MANAGER:add_event(Event({
                delay = .5,
                func = function ()
                    card:shatter()
                    return true
                end
            }))
            return
        end

        if after and (pre.config.center_key == "j_kmod_prism" or pre.config.center_key == "j_kmod_broken_mirror") then
            G.E_MANAGER:add_event(Event({
                delay = .5,
                func = function ()
                    card:shatter()
                    return true
                end
            }))
            return
        end

        if pre ~= nil then
            local ret = SMODS.blueprint_effect(card, pre, context)
            if ret then card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Again!', colour = G.C.CHIPS}) SMODS.calculate_effect(ret, pre) end
        end

        if after ~= nil then
            local ret = SMODS.blueprint_effect(card, after, context)
            if ret then card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Again!', colour = G.C.CHIPS}) SMODS.calculate_effect(ret, after) end
        end

        return {}
    end,
    in_pool = function(self, args)
        if G.GAME.mirror_broke == true then
            return true, {allowed_duplicates = false}
        end
        return false, {allowed_duplicates = false}
    end
})