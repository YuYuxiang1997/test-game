function Obelisk() constructor{
	built = false;
	level = 0;
	cost = function() {
		return power(10,level+8)
	}
}

function prestige() {
	throw("not implemented")
}

function can_prestige() {
	return obj_main.game_state.obelisk.built
}

function get_obelisk_upgrade_cost() {
	return obj_main.game_state.obelisk.cost()
}

function get_mana_from_prestige() {
	return power(2,obj_main.game_state.obelisk.level-1)*get_trinket_effect(TRINKET.MANA)
}

function upgrade_obelisk() {
	var _obelisk = obj_main.game_state.obelisk
	if (get_gold() < _obelisk.cost()) {
		return
	}
	spend_gold(_obelisk.cost())
	if (_obelisk.built) {
		_obelisk.level += 1
	} else {
		_obelisk.level += 1
		_obelisk.built = true
	}
}

function create_prestige_instances() {
	instance_create_layer(1000,50,"Instances",obj_prestige_button)
	instance_create_layer(1030,650,"Instances",obj_prestige_upgrade)
}

function draw_obelisk() {
	var _subimg
	if (obj_main.game_state.obelisk.built) {
		_subimg = 1
	} else {
		_subimg = 0
	}
	draw_sprite_ext(sprite_index,_subimg,x,y,1,1,0,c_white,1)
}