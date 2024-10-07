/// @description Insert description here
// You can write your code in this editor
if (obj_main.game_state.active_tab == TABS.PRESTIGE && can_prestige()) {
	draw_sprite_ext(sprite_index,sub_img,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_text(x+120,y+50,string_concat("prestige for: ",print_num(get_mana_from_prestige(),true)," mana"))
}