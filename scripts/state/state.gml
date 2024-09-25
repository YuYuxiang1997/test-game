// Update values directly, never read directly
enum TABS {
	NOTHING,
	FOOD,
	LOG,
	ORE,
}

function init_state() {
	var _resource_node_slots = []
	for (var _i = 0; _i < 25; _i++) {
		array_push(_resource_node_slots, new ResourceNodeSlot(_i))
	}
	
	return {
		total_gold : 0,
		population_mult : 1,
		log : 0,
		resource_node_production_mult : 1,
	
		resource_nodes : [],
		resource_node_slots : _resource_node_slots,
		log_upgrades: [],
		active_tab: TABS.NOTHING,
	
		get_gold : function() {return total_gold},
	}
}

function get_population() {
	var _sum = 0
	for (_i = 0; _i < array_length(obj_main.game_state.resource_nodes); _i++) {
		var _node = obj_main.game_state.resource_nodes[_i]
		if (_node.type == RESOURCE_NODES.FOOD) {
			_sum += _node.level
		}
	}
	return _sum*obj_main.game_state.population_mult
}

function get_gold() {
	return obj_main.game_state.total_gold
}

function spend_gold(_gold) {
	obj_main.game_state.total_gold -= _gold
}

function get_log_income() {
	var _sum = 0
	for (var _i = 0; _i < array_length(obj_main.game_state.resource_nodes); _i++) {
		var _node = obj_main.game_state.resource_nodes[_i]
		if (_node.type == RESOURCE_NODES.WOOD) {
			_sum += _node.level
		}
	}
	return _sum
}

function get_income(_g) {
	return get_income_from(RESOURCE_NODES.FOOD)
	//return get_income_from(RESOURCE_NODES.FOOD) + get_income_from(RESOURCE_NODES.WOOD) + get_income_from(RESOURCE_NODES.ORE)
}

function get_income_from(_node_enum) {
	
	var _sum = 0
	if (_node_enum == RESOURCE_NODES.FOOD) {
	}
	for (var _i = 0; _i < array_length(obj_main.game_state.resource_nodes); _i++) {
		var _node = obj_main.game_state.resource_nodes[_i]
		var _test = _i
		var _len = array_length(obj_main.game_state.resource_nodes)
		if (_node.type == _node_enum) {
			_sum += _node.base_gain*_node.level*get_idle_population_boost(get_population())*obj_main.game_state.resource_node_production_mult
		}
	}
	return _sum
}

function update_state(_game_state) {
	_game_state.total_gold += get_income(_game_state)*delta_time/1000000
	_game_state.log += get_log_income()*delta_time/1000000
}

function get_node_slot(_nodeid) {
	return obj_main.game_state.resource_node_slots[_nodeid]
}

function get_resource_node(_nodeid) {
	return obj_main.game_state.resource_nodes[_nodeid]
}

function add_resource_node(_node) {
	array_push(obj_main.game_state.resource_nodes,_node)
}