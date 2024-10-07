//TODO For the future:
//Don't have individual sprites for each tab. Have a background with multiple subimages to change between
//for active tab/hovered state, then draw the text/icon over it
var _alpha = resource_tab_id == obj_main.game_state.active_tab ? 1 : 0.5
if (hovered) {
	_alpha = 1
	draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,0,c_green,_alpha)
} else {
	draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,0,c_white,_alpha)
}
	