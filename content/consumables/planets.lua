SMODS.Consumable {
    set = 'Planet',
    key = 'dimidium',
    config = { hand_type = 'kmod_blackjack' },
    pos = {x = 1, y = 0 },
    atlas = 'consumables',
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet_q'), get_type_colour(self or card.config, card), nil, 1.2)
    end,
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    generate_ui = 0,
    loc_txt = {
        name = "Dimidium",
    }
}