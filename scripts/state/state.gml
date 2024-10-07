// Update values directly, never read directly
enum TABS {
	FOOD,
	LOG,
	ORE,
	PRESTIGE,
	NOTHING
}

enum SCREENS {
	BASE,
	PICK_RESOURCE_NODE,
}

enum POPULATION_ALLOC {
	WOOD,
	ORE,
}

function init_state() {
	var _resource_node_slots = []
	for (var _i = 0; _i < 24; _i++) {
		array_push(_resource_node_slots, new ResourceNodeSlot(_i))
	}
	var _gold_tile = new GoldTile()
	
	return {
		total_gold : 0,
		population_mult : 1,
		population_alloc : {
			wood: 0,
			ore: 0,
		},
		log : 0,
		log_mult : 1,
		upgrade_speed_mult : 1,
		resource_node_production_mult : 1,
		currently_upgrading_id : -1,
		
		metal_mult : 1,
	
		gold_tile : _gold_tile,
		resource_nodes : [],
		resource_node_slots : _resource_node_slots,
		log_upgrades: [],
		trinkets: [],
		
		obelisk: new Obelisk(),
		
		active_tab: TABS.NOTHING,
		active_screen: SCREENS.BASE,
	
		get_gold : function() {return total_gold},
		
		click_income : function() {
			return get_trinket_effect(TRINKET.CLICK_POWER)
		}
	}
}

function get_active_screen() {
	return obj_main.game_state.active_screen
}

function set_active_screen(_screen) {obj_main.game_state.active_screen = _screen}

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

function get_idle_pop() {
	var _pop_alloc = obj_main.game_state.population_alloc
	return get_population() - _pop_alloc.wood - _pop_alloc.ore 
}

function get_builders() {
	return obj_main.game_state.population_alloc.wood
}

function get_upgrade_speed() {
	return get_builders()*obj_main.game_state.upgrade_speed_mult*get_trinket_effect(TRINKET.BUILD_SPEED)
}

function set_currently_upgrading(_id) {
	obj_main.game_state.currently_upgrading_id = _id
}

function get_currently_upgrading() {
	return get_upgrade(obj_main.game_state.currently_upgrading_id)
}

function get_blacksmiths() {
	return obj_main.game_state.population_alloc.ore
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
	_sum *= get_trinket_effect(TRINKET.LOG_GAIN)
	return _sum*obj_main.game_state.log_mult
}

function get_metal_income() {
	var _sum = 0
	for (var _i = 0; _i < array_length(obj_main.game_state.resource_nodes); _i++) {
		var _node = obj_main.game_state.resource_nodes[_i]
		if (_node.type == RESOURCE_NODES.ORE) {
			_sum += _node.level
		}
	}
	return _sum*obj_main.game_state.metal_mult
}


function get_income(_g) {
	return get_income_from(RESOURCE_NODES.FOOD) + get_income_from(RESOURCE_NODES.WOOD) + get_income_from(RESOURCE_NODES.ORE)
}

function get_income_from(_node_enum) {
	
	var _sum = 0
	for (var _i = 0; _i < array_length(obj_main.game_state.resource_nodes); _i++) {
		var _node = obj_main.game_state.resource_nodes[_i]
		var _test = _i
		var _len = array_length(obj_main.game_state.resource_nodes)
		if (_node.type == _node_enum) {
			_sum += _node.base_gain*_node.level*get_idle_population_boost()*obj_main.game_state.resource_node_production_mult
		}
	}
	if (_node_enum == RESOURCE_NODES.FOOD) {
		_sum *= get_trinket_effect(TRINKET.FOOD_PROD)
	} else if (_node_enum == RESOURCE_NODES.WOOD) {
		_sum *= get_trinket_effect(TRINKET.WOOD_PROD)
	} else if (_node_enum == RESOURCE_NODES.ORE) {
		_sum *= get_trinket_effect(TRINKET.ORE_PROD)
	}
	return _sum
}

function update_state(_game_state) {
	_game_state.total_gold += get_income(_game_state)*delta_time/1000000
	_game_state.log += get_log_income()*delta_time/1000000
	step_upgrade()
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