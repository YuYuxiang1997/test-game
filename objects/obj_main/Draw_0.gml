/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_money)
draw_set_halign(fa_right)
draw_text(700,100,print_num(game_state.get_gold(),true))

draw_set_font(fnt_money_small)
draw_text(700,200,string_concat("+",print_num(get_income(game_state),false),"/s"))
draw_set_halign(fa_center)

draw_line_width(899,32,1500,32,3)
draw_line_width(899,766,1500,766,3)
draw_line_width(899,32,899,1500,3)
draw_line_width(1366,32,1366,1500,3)
draw_food_tab()
draw_wood_tab()
draw_ore_tab()


if (get_active_screen() == SCREENS.PICK_RESOURCE_NODE) {
	draw_set_color(c_black);
	draw_set_alpha(.5);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1)
}