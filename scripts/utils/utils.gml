function print_num(_num) {
	var _counter = 0
	if (_num > 9999) {
		while (_num >= 10) {
			_num /= 10
			_counter ++ 
		}
		return string_concat(round(_num*100)/100,"e",_counter)
	} else {
		return round(_num)
	}
}

function get_idle_population_boost(_p){
	return 1+(0.1*_p)
}