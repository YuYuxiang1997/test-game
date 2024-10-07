/// @description Insert description here
// You can write your code in this editor
if (obj_main.game_state.active_tab == TABS.PRESTIGE) {
	draw_sprite_ext(sprite_index,sub_img,x,y,image_xscale,image_yscale,0,c_white,1)
	if (obj_main.game_state.obelisk.built) {
		draw_text(x+90,y+20,"upgrade")
	} else {
		draw_text(x+90,y+20,"build")
	}
	draw_text(x+90,y+35,print_num(obj_main.game_state.obelisk.cost(),true))
}