enum RESOURCE_NODES {
	FOOD,
	WOOD,
	ORE,
}

function ResourceNodeSlot(_number) constructor{
	slot_id = _number
	slot_bought = false
	slot_cost = 10*power(10,_number)
	var _x = 50+80*(_number mod 5)
	var _y = 50+130*(_number div 5)
	var _ins = instance_create_layer(_x,_y,"Instances",obj_resource_node_plot)
	ins = _ins
	_ins.plot_id = slot_id
}

function ResourceNode(_type,_x,_y) constructor{
	level = 0
	cost_factor = 1.15
	type = _type
	node_id = obj_main.global_node_id
	if (type == RESOURCE_NODES.FOOD) {
		base_gain = 1
		base_cost = 10
		instance = instance_create_layer(_x,_y,"Instances",obj_food)
	} else if (type == RESOURCE_NODES.WOOD) {
		base_gain = 100
		base_cost = 1000
		instance = instance_create_layer(_x,_y,"Instances",obj_tree)
	} else if (type == RESOURCE_NODES.ORE) {
		base_gain = 10000
		base_cost = 1000000
		instance = instance_create_layer(_x,_y,"Instances",obj_ore)
	}
	instance.nodeid = obj_main.global_node_id
	cost = function () {
		return base_cost*power(cost_factor,level)
	}
	obj_main.global_node_id += 1
}

function get_plot_cost(_nodeid) {
	return obj_main.game_state.resource_node_slots[_nodeid].slot_cost
}

function upgrade_resource_node(_nodeid) {
	var _node_struct = obj_main.game_state.resource_nodes[_nodeid]
	if (obj_main.game_state.total_gold >= _node_struct.cost()) {
		obj_main.game_state.total_gold -= _node_struct.cost()
		_node_struct.level += 1
	}
}

function draw_resource_plot(_nodeid) {
	draw_sprite(sprite_index,-1,x,y)
	var _cost = get_plot_cost(_nodeid)
	if (get_gold() >= _cost) {
		draw_set_color(c_green)
		draw_text(x+32,y+32,print_num(_cost))
		draw_set_color(c_white)
	} else {
		draw_set_color(c_red)
		draw_text(x+32,y+32,print_num(_cost))
		draw_set_color(c_white)
	}
}

function buy_node_plot(_nodeid) {
	// Add UI for picking node here
	var _cost = get_plot_cost(_nodeid)
	if (get_gold() >= _cost) {
		spend_gold(_cost)
		var _node_slot = get_node_slot(_nodeid)
		var _x = _node_slot.ins.x
		var _y = _node_slot.ins.y
		instance_destroy(_node_slot.ins)
		_node_slot.slot_bought = true
		var _resource_node = new ResourceNode(RESOURCE_NODES.FOOD,_x,_y)
		add_resource_node(_resource_node)
	}
}

function draw_resource_nodes(_nodeid) {
	image_xscale = 2
	image_yscale = 2
	draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_text(x+32,y+80,print_num(get_resource_node(_nodeid).cost()))
	draw_set_color(c_green)
	draw_set_halign(fa_right)
	draw_text(x+60,y+10,print_num(get_resource_node(_nodeid).level))
	draw_set_halign(fa_center)
	draw_set_color(c_white)
}