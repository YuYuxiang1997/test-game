// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LogUpgrade (_cost,_name,_buy,_sprite,_id) constructor{;
	bought = false;
	cost = _cost;
	name = _name;
	buy = _buy;
	sprite = _sprite;
	upgrade_id = _id;
}

#macro UPGRADE_SCALE 0.7
#macro UPGRADE_DRAW_START_X 900
#macro UPGRADE_DRAW_START_Y 400

function create_log_upgrades() {
	_up_1 = new LogUpgrade(100,"upgrade 1", function() {obj_main.game_state.resource_node_production_mult *= 2},spr_upgrade_1, 0)
	array_push(obj_main.game_state.log_upgrades, _up_1)
	
	_up_2 = new LogUpgrade(1000,"upgrade 2", function() {obj_main.game_state.population_mult *= 2},spr_upgrade_2, 1)
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
		if (!obj_main.game_state.log_upgrades[_i].bought) {
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

function buy_upgrade(_id) {
	var _upgrade = get_upgrade(_id)
	if (obj_main.game_state.log >= _upgrade.cost) {
		obj_main.game_state.log -= _upgrade.cost
		_upgrade.bought = true
		_upgrade.buy()
	}
}

function sort_upgrades() {
	sort_function = function(_a,_b) {
		if (_a.bought) {
			return 1;
		}
		if (_b.bought) {
			return -1;
		}
		return _a.cost-_b.cost
	}
	array_sort(obj_main.game_state.log_upgrades,sort_function)
}
	