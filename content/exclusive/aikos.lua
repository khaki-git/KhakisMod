if SMODS.find_mod("aikoyorisshenanigans") then
    print("found aikos bullshit")

    KMOD.played_words = {}

    SMODS.Blind({
        atlas = "kmod_blinds", pos = {y = 5},
        key = "qup",
        loc_txt = {name = "The Qup", text = {"Repeat words cannot", "be played."}},
        boss = {min = 1, max = 10},
        dollars = 5,
        mult = 2,
        boss_colour = HEX('0075EB'),
        in_pool = function(self)
            if G.GAME.letters_enabled then return true end
            return false
        end,
        debuff_hand = function(cards, hand, handname, check)
            local word = G.GAME.aiko_current_word
            
            if not word then return false end
            word = string.lower(word)
            local lowerword = string.lower(word)
            word = string.gsub(" " .. word, "%W%l", string.upper):sub(2)

            for _, played in pairs(KMOD.played_words) do
                if played == word then
                    return true
                end
            end
        end
    })

    local calc_hook = SMODS.calculate_context

    function SMODS.calculate_context(context, return_table)
        local x = calc_hook(context, return_table)

        if G.GAME.letters_enabled and G.GAME.aiko_current_word then
            local word = G.GAME.aiko_current_word
            
            if not word then return {} end
            word = string.lower(word)
            local lowerword = string.lower(word)
            word = string.gsub(" " .. word, "%W%l", string.upper):sub(2)

            if context.before then
                table.insert(KMOD.played_words, word)
            end
        end
        
        return x
    end
end