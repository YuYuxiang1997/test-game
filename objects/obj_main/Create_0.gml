total_gold = 0
population = 0
log = 0

food_ins = new ResourceNode("food");
food_ins.instance.nodeid = 0;
wood_ins = new ResourceNode("wood");
wood_ins.instance.nodeid = 1;
ore_ins = new ResourceNode("ore");
ore_ins.instance.nodeid = 2;
instance_create_layer(900,0,"Instances",obj_food_tab)
instance_create_layer(932,0,"Instances",obj_tree_tab)
instance_create_layer(964,0,"Instances",obj_ore_tab)

is_active = [false,false,false]
node_ins = [food_ins,wood_ins,ore_ins]