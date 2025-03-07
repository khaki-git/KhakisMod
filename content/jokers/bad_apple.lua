badapple_animation = 0
badapple_animation_dt = 0

SMODS.Joker({
    key = "bad_apple",
    loc_txt = {name = "Bad Apple", text = {"{C:blue}+1{} Chips for the current", "animation frame this card is on.", "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)"}},
    atlas = "badapple",
    config = { extra = {}},
    loc_vars = function(self, info_queue, card)
        local obj = G.P_CENTERS.j_kmod_bad_apple
        return {
            vars = {
                obj.pos.x + obj.pos.y * 75
            }
        }
    end,
    calculate = function(self, card, context)
        local obj = G.P_CENTERS.j_kmod_bad_apple
        local chips = obj.pos.x + obj.pos.y * 75

        if context.joker_main then
            local obj = G.P_CENTERS.j_kmod_bad_apple
            local chips = obj.pos.x + obj.pos.y * 75

            return {
                chips = chips
            }
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