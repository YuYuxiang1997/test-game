//Global variables
global_node_id = 0

game_state = init_state()
show_debug_message(game_state)

instance_create_layer(900,0,"Instances",obj_food_tab)
instance_create_layer(932,0,"Instances",obj_tree_tab)
instance_create_layer(964,0,"Instances",obj_ore_tab)

log_upgrades_ins = []
population_tab_buttons_ins = []
ore_tab_buttons_ins = []
trinket_ins = []

create_log_upgrades()
create_trinkets()

blocking_flags = {
	pick_resource_flag : false
}