/// @description Insert description here
// You can write your code in this editor
if (get_active_screen() != SCREENS.BASE) {
	return
}
	
drag_start_x = event_data[? "posX"]
drag_start_y = event_data[? "posY"]

saved_camera_x = camera_x
saved_camera_y = camera_y