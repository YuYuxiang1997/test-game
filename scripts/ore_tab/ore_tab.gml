enum TRINKET {
	FOOD_PROD,
	WOOD_PROD,
	ORE_PROD,
	LOG_GAIN,
	BUILD_SPEED,
	MANA,
	CLICK_POWER,
}

#macro TRINKET_LEVEL_PROF_MULT 3
#macro TRINKET_LEVEL_EFFECT_MULT 2
#macro TRINKET_LEVEL_DRAIN_MULT 1.5
#macro BLACKSMITH_EFFECT 0.5

function Trinket(_type,_base_effect, _base_drain, _level_req) constructor{
	type = _type;
	level = 1;
	cur_level = 1;
	base_effect = _base_effect
	base_drain = _base_drain
	level_req = _level_req
	cur_prof = 0;
	is_active = false;
	effect = function() {
		return 1+base_effect*TRINKET_LEVEL_EFFECT_MULT*cur_level
	}
	print_msg = function() {
		return string_concat("Effect: ",effect())
	}
	drain = function() {
		return base_drain*TRINKET_LEVEL_DRAIN_MULT*cur_level
	}
	drain_msg = function() {
		return string_concat("Drain: ",drain())
	}
	current_req = function() {
		return level_req*TRINKET_LEVEL_PROF_MULT*level
	}
	
	//Should UI be flipped
	flipped = (_type == TRINKET.WOOD_PROD) || (_type == TRINKET.LOG_GAIN) || (_type == TRINKET.MANA) 
}

function draw_ore_tab() {	
	var _percentage = 100*get_income_from(RESOURCE_NODES.ORE)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.ORE) { 
		draw_text(1100,100,"Ore")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.ORE),false),"/s (",_percentage,"%)"))
		
		draw_text(1100,300,string_concat("Metal production: ",print_num(get_metal_income(),false)))
		draw_text(1100,325,string_concat("Metak drain: ",print_num(get_total_drain(),false)))
	}
}

function get_total_drain() {
	var _sum = 0;
	var _trinket;
	for (var _i = 0; _i < array_length(obj_main.game_state.trinkets); _i++) {
		_trinket = obj_main.game_state.trinkets[_i]
		if (_trinket.is_active) {
			_sum += _trinket.drain()
		}
	}
	return _sum;
}


function modify_trinket_level(_type,_amount) {
	var _trinket = get_trinket(_type)
	if (_amount > 0) {
		if (_trinket.level - _trinket.cur_level < _amount) {
			return
		}
	} else {
		if (_trinket.cur_level + _amount < 1) {
			return
		}
	}
	_trinket.cur_level += _amount
	if (_trinket.is_active && get_total_drain() > get_metal_income()) {
		_trinket.cur_level -= _amount
	}
}

function get_trinket(_type) {
	for (var _i = 0; _i < array_length(obj_main.game_state.trinkets); _i++) {
		var _t = obj_main.game_state.trinkets[_i]
		if (_t.type == _type) {
			return _t
		}
	}
}

function toggle_trinket(_type) {
	var _trinket = get_trinket(_type)
	if (_trinket.is_active) {
		_trinket.is_active = false
	} else {
		_trinket.is_active = true
		if (get_total_drain() > get_metal_income()) {
			_trinket.is_active = false
		}
	}
}

function step_trinket(_type) {
	var _trinket = get_trinket(_type)
	if (!_trinket.is_active) {
		return
	}
	_trinket.cur_prof += 1+get_blacksmiths()*BLACKSMITH_EFFECT
	if (_trinket.cur_prof >= _trinket.current_req()) {
		_trinket.cur_prof = 0
		_trinket.level += 1
	}
}

function draw_trinket(_type) {
	var _trinket = get_trinket(_type)
	draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,0,c_white,_trinket.is_active ? 1 : 0.5)
	draw_circular_bar(x+34 ,y+34 ,_trinket.cur_prof, _trinket.current_req(), c_green, 27, _trinket.is_active ? 1 : 0.5, 3)
	draw_text(x+35,y+40,_trinket.level)
	if (_trinket.flipped) {
		draw_set_halign(fa_left)
		draw_text(x+70,y+30,_trinket.cur_level)
		draw_text(x+140,y+20,_trinket.print_msg())
		draw_text(x+140,y+35,_trinket.drain_msg())
		draw_set_halign(fa_center)
	} else {
		draw_set_halign(fa_right)
		draw_text(x,y+30,_trinket.cur_level)
		draw_text(x-70,y+20,_trinket.print_msg())
		draw_text(x-70,y+35,_trinket.drain_msg())
		draw_set_halign(fa_center)
	}
}


function create_trinkets() {
	var _trinket = [
		[TRINKET.FOOD_PROD	,0.2	,1		,100	,1060,375,spr_trinket_food], //Type, base_effect, base_drain, level_req, x, y, sprite
		[TRINKET.WOOD_PROD	,0.2	,1		,500	,1120,375,spr_trinket_food],
		[TRINKET.ORE_PROD	,0.2	,2		,1000	,1060,435,spr_trinket_food],
		[TRINKET.LOG_GAIN	,0.5	,5		,750	,1120,435,spr_trinket_food],
		[TRINKET.BUILD_SPEED,1		,10		,1250	,1060,495,spr_trinket_food],
		[TRINKET.MANA		,0.1	,1		,10000	,1120,495,spr_trinket_food],
		[TRINKET.CLICK_POWER,2		,2		,100	,1060,555,spr_trinket_food],
	];
	var _ins;
	for (var _i = 0; _i < array_length(_trinket); _i++ ) {
		array_push(obj_main.game_state.trinkets,new Trinket(_trinket[_i][0],_trinket[_i][1],_trinket[_i][2], _trinket[_i][3]))
		_ins = instance_create_layer(_trinket[_i][4],_trinket[_i][5],"Instances",obj_trinket,{sprite_index: _trinket[_i][6],type: _trinket[_i][0]})
		array_push(obj_main.trinket_ins,_ins)
		
		//Buttons, dont think theres a need to create an array to store this
		var _flipped = (_trinket[_i][0] == TRINKET.WOOD_PROD) || (_trinket[_i][0] == TRINKET.LOG_GAIN) || (_trinket[_i][0] == TRINKET.MANA) 
		instance_create_layer(_trinket[_i][4]+(_flipped ? 80 : -50),_trinket[_i][5]+10,"Instances",obj_modify_trinket_level, {type: _trinket[_i][0], amount: 1, sprite_index: spr_add, image_xscale: 0.4, image_yscale: 0.4})
		instance_create_layer(_trinket[_i][4]+(_flipped ? 80 : -50),_trinket[_i][5]+30,"Instances",obj_modify_trinket_level, {type: _trinket[_i][0], amount: -1, sprite_index: spr_sub, image_xscale: 0.4, image_yscale: 0.4})
	}
	show_debug_message(obj_main.game_state.trinkets)
}

function get_trinket_effect(_type) {
	var _trinket = get_trinket(_type)
	return _trinket.is_active ? _trinket.effect() : 1
}
