// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_food_tab() {
	var _percentage = 100*obj_main.node_ins[0].income()/get_total_income()
	if (obj_main.is_active[0]) { //check is active here
		draw_text(1100,100,"Food")
		draw_text(1100,150,string_concat("Level: ",obj_main.node_ins[0].level))
		draw_text(1100,200,string_concat("+",print_num(obj_main.node_ins[0].income()),"/s (",_percentage,"%)"))
		
		//Population
		draw_text(1100,300,string_concat("Population: ",population))
		draw_text(1100,350,string_concat("Idle: ",population,", boosting resource gain by x",get_idle_population_boost()))
	}
}


function draw_wood_tab() {
	var _percentage = 100*obj_main.node_ins[1].income()/get_total_income()
	if (obj_main.is_active[1]) { //check is active here
		draw_text(1100,100,"Wood")
		draw_text(1100,150,string_concat("Level: ",obj_main.node_ins[1].level))
		draw_text(1100,200,string_concat("+",print_num(obj_main.node_ins[1].income()),"/s (",_percentage,"%)"))
		
		//Upgrades
		draw_text(1100,300,string_concat("Logs: ",print_num(log)))
	}
}


function draw_ore_tab() {
	var _percentage = 100*obj_main.node_ins[2].income()/get_total_income()
	if (obj_main.is_active[2]) { //check is active here
		draw_text(1100,100,"Ore")
		draw_text(1100,150,string_concat("Level: ",obj_main.node_ins[2].level))
		draw_text(1100,200,string_concat("+",print_num(obj_main.node_ins[2].income()),"/s (",_percentage,"%)"))
	}
}
