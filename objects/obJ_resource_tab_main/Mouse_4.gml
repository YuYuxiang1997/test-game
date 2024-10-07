/// @description Insert description here
// You can write your code in this editor
switch (resource_tab_id)
{
	case 0:
		obj_main.game_state.active_tab = TABS.FOOD
		break;
	case 1:
		obj_main.game_state.active_tab = TABS.LOG
		break;
	case 2:
		obj_main.game_state.active_tab = TABS.ORE
		break;
	case 3:
		obj_main.game_state.active_tab = TABS.PRESTIGE
}