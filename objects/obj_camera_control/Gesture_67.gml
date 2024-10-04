/// @description Insert description here
// You can write your code in this editor

if (get_active_screen() != SCREENS.BASE) {
	return
}
camera_x = saved_camera_x + drag_start_x - event_data[? "posX"]
camera_y = saved_camera_y + drag_start_y - event_data[? "posY"]