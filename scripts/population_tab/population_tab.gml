function draw_food_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.FOOD)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.FOOD) { 
		draw_text(1100,100,"Food")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.FOOD),false),"/s (",_percentage,"%)"))
		
		draw_population_alloc()
	}
}

function draw_population_alloc() {
	if (array_length(obj_main.population_tab_buttons_ins) == 0){
		var _ins;
		_ins = instance_create_layer(1100,420,"Instances",obj_modify_pop_alloc, {pop_type: POPULATION_ALLOC.WOOD, amount: -1, sprite_index: spr_sub, image_xscale: 0.4, image_yscale: 0.4})
		array_push(obj_main.population_tab_buttons_ins, _ins)
		_ins = instance_create_layer(1150,420,"Instances",obj_modify_pop_alloc, {pop_type: POPULATION_ALLOC.WOOD, amount: 1, sprite_index: spr_add, image_xscale: 0.4, image_yscale: 0.4})
		array_push(obj_main.population_tab_buttons_ins, _ins)
		_ins = instance_create_layer(1100,470,"Instances",obj_modify_pop_alloc, {pop_type: POPULATION_ALLOC.ORE, amount: -1, sprite_index: spr_sub, image_xscale: 0.4, image_yscale: 0.4})
		array_push(obj_main.population_tab_buttons_ins, _ins)
		_ins = instance_create_layer(1150,470,"Instances",obj_modify_pop_alloc, {pop_type: POPULATION_ALLOC.ORE, amount: 1, sprite_index: spr_add, image_xscale: 0.4, image_yscale: 0.4})
		array_push(obj_main.population_tab_buttons_ins, _ins)
	}
	
	var _total_pop = get_population()
	var _idle = get_idle_pop()
	draw_text(1100,300,string_concat("Population: ",_total_pop))
	draw_text(1100,350,string_concat("Idle: ",_idle,", boosting resource gain by x",get_idle_population_boost(_idle)))
	
	draw_text(1000,425,string_concat("Builders: ",get_builders()))
	draw_text(1000,475,string_concat("Blacksmiths: ",get_blacksmiths()))
	
}

function modify_population_alloc(_type,_amount) {
	if (_amount > 0) {
		//Adding pop, check free pop 
		if (get_idle_pop() < _amount) {
			return
		}
	}
	if (_type = POPULATION_ALLOC.WOOD) {
		if (get_builders() + _amount < 0) {
			return
		}
		obj_main.game_state.population_alloc.wood += _amount
	} else if (_type = POPULATION_ALLOC.ORE) {
		if (get_blacksmiths() + _amount < 0) {
			return
		}
		obj_main.game_state.population_alloc.ore += _amount
	}
}