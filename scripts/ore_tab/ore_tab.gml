function draw_ore_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.ORE)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.ORE) { 
		draw_text(1100,100,"Ore")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.ORE),false),"/s (",_percentage,"%)"))
	}
}
