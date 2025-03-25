if SMODS.find_mod("aikoyorisshenanigans") then
    print("found aikos bullshit")

    KMOD.played_words = {}
    KMOD.recent_word = nil

    SMODS.Blind({
        atlas = "kmod_blinds", pos = {y = 5},
        key = "qup",
        loc_txt = {name = "The Qup", text = {"Repeated words crash", "your game."}}, -- TODO: change when steamodded fixes their shitty api
        boss = {min = 1, max = 10},
        dollars = 5,
        mult = 2,
        boss_colour = HEX('0075EB'),
        in_pool = function(self)
            if G.GAME.akyrs_character_stickers_enabled then return true end
            return false
        end,
        debuff_hand = function(cards, hand, handname, check)
            local w = ""
            for _,c in ipairs(hand) do
                w=w..string.lower(c.ability.aikoyori_letters_stickers)
            end
            for _,uw in ipairs(KMOD.played_words) do
                print(w, uw)
                if w==uw then
                    return true
                end
            end
            return false
        end
    })

    local calc_hook = SMODS.calculate_context

    function SMODS.calculate_context(context, return_table)
        local x = calc_hook(context, return_table)

        if G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_wording_enabled and G.GAME.aiko_current_word then
            local word = G.GAME.aiko_current_word
            if not word then return x end
            word = string.lower(word)
            local lowerword = string.lower(word)
            word = string.gsub(" " .. word, "%W%l", string.upper):sub(2)
            if context.before then
                table.insert(KMOD.played_words, string.lower(word))
            end
        end
        
        return x
    end
end