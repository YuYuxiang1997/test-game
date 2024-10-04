enum RESOURCE_NODES {
	FOOD,
	WOOD,
	ORE,
}

#macro WOOD_UNLOCK_COST 1000
#macro ORE_UNLOCK_COST 1000000

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
	level = 1
	cost_factor = 1.15
	type = _type
	node_id = obj_main.global_node_id
	if (type == RESOURCE_NODES.FOOD) {
		base_gain = 0.5
		base_cost = 15
		instance = instance_create_layer(_x,_y,"Instances",obj_food)
	} else if (type == RESOURCE_NODES.WOOD) {
		base_gain = 20
		base_cost = 2000
		instance = instance_create_layer(_x,_y,"Instances",obj_tree)
	} else if (type == RESOURCE_NODES.ORE) {
		base_gain = 10000
		base_cost = 2500000
		instance = instance_create_layer(_x,_y,"Instances",obj_ore)
	}
	instance.nodeid = obj_main.global_node_id
	cost = function () {
		return base_cost*power(cost_factor,level-1)
	}
	obj_main.global_node_id += 1
}

function get_plot_cost(_nodeid) {
	return obj_main.game_state.resource_node_slots[_nodeid].slot_cost
}

function upgrade_resource_node(_nodeid) {
	if (get_active_screen() != SCREENS.BASE) {
		return
	}
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
	if (get_active_screen() != SCREENS.BASE) {
		return
	}
	var _cost = get_plot_cost(_nodeid)
	if (get_gold() >= _cost) {
		render_pick_resource_screen(_nodeid)
		set_active_screen(SCREENS.PICK_RESOURCE_NODE)
		spend_gold(_cost)
	}
}

function render_pick_resource_screen(_nodeslot) {
	var _ins = instance_create_layer(room_width/2-300,room_height/2-50,"Instances",obj_resource_node_pick_option)
	_ins.node_type = RESOURCE_NODES.FOOD
	_ins.node_slot = _nodeslot
	_ins = instance_create_layer(room_width/2,room_height/2-50,"Instances",obj_resource_node_pick_option)
	_ins.node_type = RESOURCE_NODES.WOOD
	_ins.node_slot = _nodeslot
	_ins = instance_create_layer(room_width/2+300,room_height/2-50,"Instances",obj_resource_node_pick_option)
	_ins.node_type = RESOURCE_NODES.ORE
	_ins.node_slot = _nodeslot
}

function pick_resource(_nodetype,_node_id) {
	var _nodeslot = get_node_slot(_node_id)
	var _x = _nodeslot.ins.map_x
	var _y = _nodeslot.ins.map_y
	show_debug_message(_nodetype)
	var _resource_node
	switch (_nodetype) {
		case RESOURCE_NODES.FOOD:
			_resource_node = new ResourceNode(RESOURCE_NODES.FOOD,_x,_y)
			add_resource_node(_resource_node)	
			set_active_screen(SCREENS.BASE)
			break
		case RESOURCE_NODES.WOOD:
			if (get_gold() >= WOOD_UNLOCK_COST) {
				_resource_node = new ResourceNode(RESOURCE_NODES.WOOD,_x,_y)
				add_resource_node(_resource_node)
				set_active_screen(SCREENS.BASE)
				spend_gold(WOOD_UNLOCK_COST)
			} else {
				return
			}
			break
		case RESOURCE_NODES.ORE:
			if (get_gold() >= ORE_UNLOCK_COST) {
				_resource_node = new ResourceNode(RESOURCE_NODES.ORE,_x,_y)
				add_resource_node(_resource_node)	
				set_active_screen(SCREENS.BASE)
				spend_gold(ORE_UNLOCK_COST)
			} else {
				return
			}
			break
	}
	instance_destroy(_nodeslot.ins)
	_nodeslot.slot_bought = true
	obj_main.blocking_flags.pick_resource_flag = true
}

function draw_resource_nodes(_nodeid) {
	image_xscale = 2
	image_yscale = 2
	draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_text(x+32,y+80,print_num(get_resource_node(_nodeid).cost(),true))
	draw_set_color(c_green)
	draw_set_halign(fa_right)
	draw_text(x+60,y+10,print_num(get_resource_node(_nodeid).level,true))
	draw_set_halign(fa_center)
	draw_set_color(c_white)
}