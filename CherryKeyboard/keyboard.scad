include <bolts.scad>
include <cherry_keyswitch.scad>

show_keyswitches = true;
show_keycaps = true;

default_key_size = cherry_mx_outer_width;
default_key_space = 3;

default_key_offset = default_key_size+default_key_space;

rows = 5;
cols = 6;

row_shift = [	[0,0],
					[1,0],
					[2,0],
					[3,0],
					[4,0],
					[0,0],
					[0,0],
					[0,0],
					[0,0],
					[0,0]];
col_shift = [	[0,0],
					[3,0],
					[5,0],
					[7,0],
					[5,0],
					[2,0],
					[0,0],
					[0,0],
					[0,0],
					[0,0]];

//col_shift = [0,0.2,0.5,0.7,0.5,0.2,0,0,0,0];
module keyboard_keys(row,col,show_part = [true,true,true,true]) {
	for( i=[0:row-1] ) {
		translate([ row_shift[i][0],i*default_key_offset,row_shift[j][1] ] )
			for( j = [0:col-1] ) {
				translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
					cherry_keyswitch(fixing_pins = true, led_pins = true, show_part = show_part);
			}
	}
}

module keyboard_plate(row,col) {
	difference() {
		cube([default_key_offset*col+default_key_space+maximum(row_shift[0]),
				default_key_offset*row+default_key_space+maximum(col_shift[0]),
				cherry_mx_mount_thickness]);

		translate([(default_key_offset+default_key_space)/2,(default_key_offset+default_key_space)/2,0])
			keyboard_keys(row,col,show_part = [false,true,false,true]);
	}
}

keyboard_plate(rows,cols);

if(show_keyswitches==true) {
	translate([(default_key_offset+default_key_space)/2,(default_key_offset+default_key_space)/2,0])
		keyboard_keys(rows,cols );
}

if( show_keycaps == true ) {
for( i=[0:rows-1] ) {
		translate([ row_shift[i][0]+1.5,i*default_key_offset,row_shift[i][1] ] )
			for( j = [0:cols-1] ) {
				translate( [j*default_key_offset,col_shift[j][0]+1.5,
								cherry_mx_top_thickness+cherry_mx_keycap_buffer+col_shift[j][1] ]) 
					color("Brown") import("includes/Key_fixed.stl");
			}
	}

}

function maximum(a, i = 0) = (i < len(a) - 1) ? max(a[i], maximum(a, i +1)) : a[i];