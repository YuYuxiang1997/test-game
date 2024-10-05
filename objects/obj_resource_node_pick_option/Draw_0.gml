/// @description Insert description here
// You can write your code in this editor
var _use_frame = 1
draw_sprite_ext(sprite_index,_use_frame,x,y,image_xscale,image_yscale,0,c_white,1)
draw_set_color(c_white)
switch (node_type) {
	case RESOURCE_NODES.FOOD:
		draw_text(x+32,y+80,"Free!")
		break
	case RESOURCE_NODES.WOOD:
		draw_text(x+32,y+80,print_num(WOOD_UNLOCK_COST))
		break
	case RESOURCE_NODES.ORE:
		draw_text(x+32,y+80,print_num(ORE_UNLOCK_COST))
		break
}