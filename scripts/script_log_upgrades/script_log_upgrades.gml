// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LogUpgrade (_cost,_name,_buy,_sprite) constructor{;
	bought = false;
	cost = _cost;
	name = _name;
	buy = _buy;
}

function create_log_upgrades() {
	obj_main.log_upgrades = []
	_up_1 = new LogUpgrade(100,"upgrade 1", function() {obj_main.food_production_mult *= 2},spr_upgrade_1)
	array_push(obj_main.log_upgrades, _up_1)
}

function render_log_upgrades() {
	//Take out the trash
	for (var _i = 0; _i < array_length(obj_main.log_upgrades_ins); _i++) {
		instance_destroy(obj_main.log_upgrades_ins[_i])
	}
	obj_main.log_upgrades_ins = []
	sort_upgrades()
	// Testing functionality, only display 5 upgrades
	for (var _i = 0; _i < min(5,array_length(obj_main.log_upgrades)); _i++) {
		if (!obj_main.log_upgrades[_i].bought) {
			array_push(obj_main.log_upgrades_ins,instance_create_layer(300,300,"Instances",obj_log_upgrade))
		}
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
	array_sort(obj_main.log_upgrades,sort_function)
}
	