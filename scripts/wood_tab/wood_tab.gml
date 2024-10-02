// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information]
enum UPGRADE_STATE {
	UNBOUGHT,
	UPGRADING,
	BOUGHT,
}

function LogUpgrade (_cost,_name,_buy,_sprite,_id,_progress_req) constructor{
	upgrade_state = UPGRADE_STATE.UNBOUGHT;
	cost = _cost;
	name = _name;
	buy = _buy;
	progress_req = _progress_req;
	current_prog = 0;
	sprite = _sprite;
	upgrade_id = _id;
}

#macro UPGRADE_SCALE 0.7
#macro UPGRADE_DRAW_START_X 900
#macro UPGRADE_DRAW_START_Y 400

function draw_wood_tab() {
	var _percentage = 100*get_income_from(RESOURCE_NODES.WOOD)/get_income(obj_main.game_state)
	if (obj_main.game_state.active_tab == TABS.LOG) { 
		draw_text(1100,100,"Wood")
		draw_text(1100,200,string_concat("+",print_num(get_income_from(RESOURCE_NODES.WOOD),false),"/s (",_percentage,"%)"))
	
		draw_text(1100,300,string_concat("Logs: ",print_num(obj_main.game_state.log,true)))
		draw_currently_upgrading()
	}
}

function create_log_upgrades() {
	_up_1 = new LogUpgrade(100,"upgrade 1", function() {obj_main.game_state.resource_node_production_mult *= 2},spr_upgrade_1, 0,100)
	array_push(obj_main.game_state.log_upgrades, _up_1)
	
	_up_2 = new LogUpgrade(1000,"upgrade 2", function() {obj_main.game_state.population_mult *= 2},spr_upgrade_2, 1,1000)
	array_push(obj_main.game_state.log_upgrades, _up_2)
}

function render_log_upgrades() {
	//Take out the trash
	for (var _i = 0; _i < array_length(obj_main.log_upgrades_ins); _i++) {
		instance_destroy(obj_main.log_upgrades_ins[_i])
	}
	obj_main.log_upgrades_ins = []
	sort_upgrades()
	// Testing functionality, only display 5 upgrades
	for (var _i = 0; _i < min(5,array_length(obj_main.game_state.log_upgrades)); _i++) {
		if (obj_main.game_state.log_upgrades[_i].upgrade_state == UPGRADE_STATE.UNBOUGHT) {
			_inst = instance_create_layer(UPGRADE_DRAW_START_X+64*UPGRADE_SCALE*_i,UPGRADE_DRAW_START_Y,"Instances",obj_log_upgrade)
			_inst.upgrade_id = game_state.log_upgrades[_i].upgrade_id
			array_push(obj_main.log_upgrades_ins,_inst)
		}
	}
		
}

function get_upgrade(_id) {
	for (var _i = 0; _i < array_length(obj_main.game_state.log_upgrades); _i++) {
		if (obj_main.game_state.log_upgrades[_i].upgrade_id = _id) {
			return obj_main.game_state.log_upgrades[_i]
		}
	}
}

function draw_upgrade(_id) {
	var _can_buy = obj_main.game_state.log >= get_upgrade(_id).cost
	var _sprite = get_upgrade(_id).sprite
	draw_sprite_ext(spr_upgrade_border,0,x,y,image_xscale,image_yscale,0,c_white,_can_buy ? 1 : 0.5)
	draw_sprite_ext(_sprite,0,x,y,image_xscale,image_yscale,0,c_white,_can_buy ? 1 : 0.5)
}

function draw_currently_upgrading() {
	if (is_any_upgrading()) {
		var _upgrading = get_currently_upgrading()
		var _sprite = _upgrading.sprite
		draw_sprite_ext(spr_upgrade_border,0,950,350,0.5,0.5,0,c_white,1)
		draw_sprite_ext(_sprite,0,950,350,0.5,0.5,0,c_white,1)
		var _progress = _upgrading.current_prog / _upgrading.progress_req
		draw_rectangle(1000,360,1250,370,true)
		draw_set_color(c_green)
		draw_rectangle(1000,360,1000+_progress*250,370,false)
		draw_set_color(c_white)
	}
}

function buy_upgrade(_id) {
	if (get_active_screen() != SCREENS.BASE || is_any_upgrading()) {
		return
	}
	var _upgrade = get_upgrade(_id)
	if (obj_main.game_state.log >= _upgrade.cost) {
		obj_main.game_state.log -= _upgrade.cost
		_upgrade.upgrade_state = UPGRADE_STATE.UPGRADING
		set_currently_upgrading(_id)
	}
}

function step_upgrade() {
	if (is_any_upgrading()) {
		var _upgrade = get_currently_upgrading()
		_upgrade.current_prog += get_upgrade_speed()*delta_time/1000000
		if (_upgrade.current_prog > _upgrade.progress_req) {
			_upgrade.upgrade_state = UPGRADE_STATE.BOUGHT
			_upgrade.buy()
		}
	}
}

function sort_upgrades() {
	sort_function = function(_a,_b) {
		if (_a.upgrade_state != UPGRADE_STATE.UNBOUGHT) {
			return 1;
		}
		if (_b.upgrade_state != UPGRADE_STATE.UNBOUGHT) {
			return -1;
		}
		return _a.cost-_b.cost
	}
	array_sort(obj_main.game_state.log_upgrades,sort_function)
}

function is_any_upgrading() {
	for (var _i = 0; _i < array_length(obj_main.game_state.log_upgrades); _i++) {
		if (obj_main.game_state.log_upgrades[_i].upgrade_state = UPGRADE_STATE.UPGRADING) {
			return true
		}
	}	
	return false
}
	