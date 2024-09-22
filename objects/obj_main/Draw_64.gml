/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_money)
draw_set_halign(fa_left)
draw_text(500,100,print_num(num))

draw_set_font(fnt_money_small)
draw_set_halign(fa_center)

for (var _i = 0; _i<3; _i++) {
	var _node = node_ins[_i]
	draw_text(_node.instance.x+15,_node.instance.y+40,string_concat("cost: ",print_num(_node.cost())))
}

draw_food_tab()
draw_wood_tab()
draw_ore_tab()