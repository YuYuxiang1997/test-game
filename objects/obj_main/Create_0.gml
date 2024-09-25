//Global variables
global_node_id = 0

game_state = init_state()
show_debug_message(game_state)

//food_ins = new ResourceNode(RESOURCE_NODES.FOOD,200,500);
//food_ins.instance.nodeid = 0;
//wood_ins = new ResourceNode(RESOURCE_NODES.WOOD,300,500);
//wood_ins.instance.nodeid = 1;
//ore_ins = new ResourceNode(RESOURCE_NODES.ORE,400,500);
//ore_ins.instance.nodeid = 2;
instance_create_layer(900,0,"Instances",obj_food_tab)
instance_create_layer(932,0,"Instances",obj_tree_tab)
instance_create_layer(964,0,"Instances",obj_ore_tab)
//game_state.resource_nodes = [food_ins,wood_ins,ore_ins]

create_log_upgrades()

log_upgrades_ins = []