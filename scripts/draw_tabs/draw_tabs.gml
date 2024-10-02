function draw_food_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.FOOD)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.FOOD) { 
		draw_text(1100,100,"Food")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.FOOD),false),"/s (",_percentage,"%)"))
		
		//Population
		var _population = get_population()
		draw_text(1100,300,string_concat("Population: ",_population))
		draw_text(1100,350,string_concat("Idle: ",_population,", boosting resource gain by x",get_idle_population_boost(_population)))
	}
}


function draw_wood_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.WOOD)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.LOG) { 
		draw_text(1100,100,"Wood")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.WOOD),false),"/s (",_percentage,"%)"))
		
		//Upgrades
		draw_text(1100,300,string_concat("Logs: ",print_num(obj_main.game_state.log,true)))
	}
}


function draw_ore_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.ORE)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.ORE) { 
		draw_text(1100,100,"Ore")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.ORE),false),"/s (",_percentage,"%)"))
	}
}
