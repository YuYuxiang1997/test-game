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

function Trinket(_type,_base_effect, _level_req) constructor{
	type = _type;
	level = 0;
	base_effect = _base_effect
	level_req = _level_req
	
	//Should UI be flipped
	flipped = (_type == TRINKET.WOOD_PROD) || (_type == TRINKET.LOG_GAIN) || (_type == TRINKET.MANA) 
}

function draw_ore_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.ORE)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.ORE) { 
		draw_text(1100,100,"Ore")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.ORE),false),"/s (",_percentage,"%)"))
		
		draw_text(1100,300,string_concat("Metal production: ",print_num(get_metal_income(),false)))
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

function draw_trinket(_type) {
	var _trinket = get_trinket(_type)
	draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,0,c_white,1)
	if (_trinket.flipped) {
		draw_text(x+70,y+30,_trinket.level)
	} else {
		draw_text(x,y+30,_trinket.level)
	}
}


//TODO: circular progress bars? http://www.davetech.co.uk/gamemakercircularhealthbars
function create_trinkets() {
	var _trinket = [
		[TRINKET.FOOD_PROD,1.2,100,1060,375,spr_trinket_food], //Type, base_effect,level_req, x, y, sprite
		[TRINKET.WOOD_PROD,1.2,500,1120,375,spr_trinket_food],
		[TRINKET.ORE_PROD,1.2,1000,1060,435,spr_trinket_food],
		[TRINKET.LOG_GAIN,1.5,750,1120,435,spr_trinket_food],
		[TRINKET.BUILD_SPEED,2,1250,1060,495,spr_trinket_food],
		[TRINKET.MANA,1.1,10000,1120,495,spr_trinket_food]
	];
	var _ins;
	for (var _i = 0; _i < array_length(_trinket); _i++ ) {
		array_push(obj_main.game_state.trinkets,new Trinket(_trinket[_i][0],_trinket[_i][1],_trinket[_i][2]))
		_ins = instance_create_layer(_trinket[_i][3],_trinket[_i][4],"Instances",obj_trinket,{sprite_index: _trinket[_i][5],type: _trinket[_i][0]})
		array_push(obj_main.trinket_ins,_ins)
	}
	show_debug_message(obj_main.game_state.trinkets)
}
