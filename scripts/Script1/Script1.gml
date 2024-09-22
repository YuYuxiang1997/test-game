// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function print_num(_num) {
	var _counter = 0
	if (_num > 9999) {
		while (_num >= 10) {
			_num /= 10
			_counter ++ 
		}
		return string_concat(round(_num*100)/100,"e",_counter)
	} else {
		return round(_num)
	}
}

function Upgrade (_cost,_name) constructor{
	bought = false;
	cost = _cost;
	name = _name;
}

function ResourceNode(_name) constructor{
	name = _name;
	level = 0
	cost_factor = 1.15
	if (_name == "food") {
		base_gain = 1
		base_cost = 10
		instance = instance_create_layer(200,150,"Instances",obj_food)
	} else if (_name == "wood") {
		base_gain = 100
		base_cost = 1000
		instance = instance_create_layer((200),(350),"Instances",obj_tree)
	} else if (_name == "ore") {
		base_gain = 10000
		base_cost = 1000000
		instance = instance_create_layer((200),(550),"Instances",obj_ore)
	}
	cost = function () {
		return base_cost*power(cost_factor,level)
	}
	income = function() {
		return base_gain*level 
	}
}

function upgrade_resource_node(_nodeid) {
	var _node_struct = obj_main.node_ins[_nodeid]
	if (obj_main.num >= _node_struct.cost()) {
		obj_main.num -= _node_struct.cost()
		_node_struct.level += 1
	}
}

function get_total_income() {
	var _income = 0
	for (var _i = 0; _i<3; _i++) {
		var _node = node_ins[_i]
		_income += _node.income()
	}
	return _income
}
