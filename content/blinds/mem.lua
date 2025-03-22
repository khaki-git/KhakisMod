SMODS.Blind({
    atlas = "kmod_blinds", pos = {y = 3},
    key = "mem",
    loc_txt = {name = "The Mem", text = {"Scoring Cards played this", "round are debuffed for", "the next Ante."}},
    boss = {min = 1, max = 15},
    dollars = 5,
    mult = 2,
    boss_colour = HEX('4B7590'),
    calculate = function(self, blind, context)
        if context.final_scoring_step then
            for i,c in pairs(context.scoring_hand) do
                G.E_MANAGER:add_event(Event({trigger = "after", delay=.3, func = function ()
                    play_sound('cancel', 0.7 + 0.05*i, 0.7)
                    c:set_debuff(true)
                    c:juice_up(0.4, 0.6)
                    c.kmod_mem_debuff = true
                    c.kmod_mem_a = 2
                    return true
                end}))
            end

            G.E_MANAGER:add_event(Event({trigger = "after", delay=1.3, func = function ()
                return true
            end}))
        end
    end,
})

calc_hook = SMODS.calculate_context

function SMODS.calculate_context(context, return_table)
    local x = calc_hook(context, return_table)

    if context.debuff_card then
        local c = context.debuff_card
        if c.kmod_mem_debuff then
            x.debuff = true
        end
    end
    if context.end_of_round and G.GAME.blind.boss then
        for _,c in pairs(G.playing_cards) do
            if c.kmod_mem_debuff then
                c.kmod_mem_a = c.kmod_mem_a - 1
                if c.kmod_mem_a == 0 then
                    c.kmod_mem_a = nil
                    c.kmod_mem_debuff = nil
                end
            end
        end
    end

    return x
end