/// @description Insert description here
// You can write your code in this editor

for (var _i = 0; _i<array_length(obj_main.is_active); _i++) {
	// show_debug_message(resource_tab_id)
	if (_i == resource_tab_id) {
		obj_main.is_active[_i] = true
	} else {
		obj_main.is_active[_i] = false
	}
}