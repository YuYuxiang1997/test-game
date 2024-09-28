function print_num(_num,_round) {
	var _counter = 0
	if (_num > 9999) {
		while (_num >= 10) {
			_num /= 10
			_counter ++ 
		}
		return string_concat(round(_num*100)/100,"e",_counter)
	} else if (_round) {
		return round(_num)
	} else {
		return _num
	}
}

function get_idle_population_boost(_p){
	return 1+(0.1*_p)
}