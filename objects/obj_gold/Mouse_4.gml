/// @description Insert description here
// You can write your code in this editor

obj_main.game_state.total_gold += obj_main.game_state.click_income()
instance_create_layer(x+random(100),y+random(10),"Instances",obj_click_number,{val: string_concat("+",obj_main.game_state.click_income()), age : 0})