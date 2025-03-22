badapple_animation = 0
badapple_animation_dt = 0

SMODS.Joker({
    key = "bad_apple",
    loc_txt = {name = "Bad Apple", text = {"At {C:attention}end of round{}, remove {C:dark_edition}Negative{}", "from a {C:attention}Joker{} and add {C:dark_edition}Negative{} to", "another {C:attention}Joker"}},
    atlas = "badapple",
    config = { extra = {}},
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card then
            local has_negative = {}
            local no_edition = {}

            for _,c in pairs(G.jokers.cards) do
                local edition_t = c.edition
                if edition_t then
                    local edition = edition_t.type
                    if edition == "negative" then
                        table.insert(has_negative, c)
                    end
                else
                    table.insert(no_edition, c)
                end
            end

            if #has_negative > 0 then
                local negative = pseudorandom_element(has_negative, pseudohash("bad_apple"))
                if negative then
                    negative:set_edition(nil)
                end
            end
            if #no_edition > 0 then
                local negative = pseudorandom_element(no_edition, pseudohash("bad_apple"))

                if negative then
                    negative:set_edition({negative = true})
                end
            end
        end
    end
})

--#region Update Checks -------------------------------------------------------------------------------------

local upd = Game.update

function Game:update(dt)
    upd(self, dt)

    badapple_animation = badapple_animation + dt
    if next(SMODS.find_card('j_kmod_bad_apple')) and not G.SETTINGS.paused then
        badapple_animation_dt = badapple_animation_dt + dt
    end

    -- Stolen Code
    if G.P_CENTERS and G.P_CENTERS.j_kmod_bad_apple and badapple_animation > 0.1 then
        badapple_animation = 0

        local obj = G.P_CENTERS.j_kmod_bad_apple

        if obj.pos.x == 7 and obj.pos.y == 30 then
            obj.pos.x = 0
            obj.pos.y = 0
        elseif obj.pos.x < 75 then
            obj.pos.x = obj.pos.x + 1
        elseif obj.pos.y < 30 then
            obj.pos.x = 0
            obj.pos.y = obj.pos.y + 1
        end
    end
    if next(SMODS.find_card('j_kmod_bad_apple')) and badapple_animation_dt > 1 then
        badapple_animation_dt = 0
    end
end