/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_money)
draw_set_halign(fa_right)
draw_text(500,100,print_num(total_gold))

draw_set_font(fnt_money_small)
draw_text(500,200,string_concat("+",print_num(get_total_income()),"/s"))
draw_set_halign(fa_center)

for (var _i = 0; _i<3; _i++) {
	var _node = node_ins[_i]
	draw_text(_node.instance.x+15,_node.instance.y+40,string_concat("cost: ",print_num(_node.cost())))
}

draw_line_width(899,32,1500,32,3)
draw_line_width(899,766,1500,766,3)
draw_line_width(899,32,899,1500,3)
draw_line_width(1366,32,1366,1500,3)
draw_food_tab()
draw_wood_tab()
draw_ore_tab()