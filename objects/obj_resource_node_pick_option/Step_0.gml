/// @description Insert description here
// You can write your code in this editor
image_xscale = 2
image_yscale = 2
switch (node_type) {
	case RESOURCE_NODES.FOOD:
		sprite_index = spr_food
		break
	case RESOURCE_NODES.WOOD:
		sprite_index = spr_tree
		break
	case RESOURCE_NODES.ORE:
		sprite_index = spr_ore
		break
}

if (get_active_screen() != SCREENS.PICK_RESOURCE_NODE) {
	instance_destroy(id)
}