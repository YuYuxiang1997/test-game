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

function get_idle_population_boost(){
	return 1+(0.1*get_idle_pop())
}

// Circular progress bars from http://www.davetech.co.uk/gamemakercircularhealthbars
function draw_circular_bar(_arg0 ,_arg1 ,_value, _max, _colour, _radius, _transparency, _width) {
    var _i, _len, _tx, _ty, _val;
    
    var _numberofsections = 60 // there is no draw_get_circle_precision() else I would use that here
    var _sizeofsection = 360/_numberofsections
    
    _val = (argument2/argument3) * _numberofsections 
    
    if (_val > 1) { // HTML5 version doesnt like triangle with only 2 sides 
    
        _piesurface = surface_create(argument5*2,argument5*2)
            
        draw_set_colour(argument4);
        draw_set_alpha(argument6);
        
        surface_set_target(_piesurface)
        
        draw_clear_alpha(c_blue,0.7)
        draw_clear_alpha(c_black,0)
        
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(argument5, argument5);
        
        for(_i=0; _i<=_val; _i++) {
            _len = (_i*_sizeofsection)+90; // the 90 here is the starting angle
            _tx = lengthdir_x(argument5, _len);
            _ty = lengthdir_y(argument5, _len);
            draw_vertex(argument5+_tx, argument5+_ty);
        }
        
        draw_primitive_end();
        
        draw_set_alpha(1);
        
        gpu_set_blendmode(bm_subtract)
        draw_set_colour(c_black)
        draw_circle(argument5-1, argument5-1,argument5-argument7,false)
        gpu_set_blendmode(bm_normal)

        surface_reset_target()
     
        draw_surface(_piesurface,argument0-argument5, argument1-argument5)
        
        surface_free(_piesurface)
        
    }
    
}