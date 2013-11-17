include <bolts.scad>
include <cherry_keyswitch.scad>

with_support = false;
show_keyswitches = true;
show_keycaps = true;

default_key_size = cherry_mx_outer_width;
default_key_space = 3;

default_key_offset = default_key_size+default_key_space;

rows = 2;
cols = 3;

row_shift = [	//[0,4],
					[1,2],
					[2,0],
					[3,2],
					[4,4],
					[0,0],
					[0,0],
					[0,0],
					[0,0],
					[0,0]];
col_shift = [	[0,2],
					[3,2],
					[5,1],
					[7,0],
					[5,1],
					[2,2],
					[0,0],
					[0,0],
					[0,0],
					[0,0]];

//col_shift = [0,0.2,0.5,0.7,0.5,0.2,0,0,0,0];
module keyboard_keys(row,col,show_part = [true,true,true,true,false,false], scale_xy = 1) {
	for( i=[0:row-1] ) {
		translate([ row_shift[i][0],i*default_key_offset,row_shift[i][1] ] )
			for( j = [0:col-1] ) {
				translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
					scale([scale_xy,scale_xy,1])
						cherry_keyswitch(fixing_pins = true, led_pins = true, show_part = show_part);
			}
	}
}

module keyboard_plate(row,col,make_flat = false,scale_xy ) {
	if( make_flat == true ) {
		translate([0,0,max(maximum1(row_shift),maximum1(col_shift))]) scale([1,1,-1])
	#		cube([default_key_offset*col+default_key_space+maximum0(row_shift),
					default_key_offset*row+default_key_space+maximum0(col_shift),
					2]);
		intersection() {
			translate([0,0,max(maximum1(row_shift),maximum1(col_shift))]) scale([1,1,-1])
				cube([default_key_offset*col+default_key_space+maximum0(row_shift),
						default_key_offset*row+default_key_space+maximum0(col_shift),
						cherry_mx_mount_thickness+5]);
			translate([(default_key_offset+default_key_space)/2,(default_key_offset+default_key_space)/2,0])
				keyboard_keys(row,col,show_part = [true,false,false,false,true,false],scale_xy = scale_xy);
		}
		difference() {
//			translate([0,0,max(maximum1(row_shift),maximum1(col_shift))]) scale([1,1,-1])
//				cube([default_key_offset*col+default_key_space+maximum0(row_shift),
//						default_key_offset*row+default_key_space+maximum0(col_shift),
//						cherry_mx_mount_thickness+5]);
			hull() {
				translate([0,0,max(maximum1(row_shift),maximum1(col_shift))]) scale([1,1,-1])
					cube([default_key_offset*col+default_key_space+maximum0(row_shift),
							default_key_offset*row+default_key_space+maximum0(col_shift),
							2]);
				for( i=[0:row-1] ) translate([ row_shift[i][0],i*default_key_offset,row_shift[i][1] ] )
					for( j = [0:col-1] ) translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
						cube([default_key_offset+default_key_space,
							default_key_offset+default_key_space,
							cherry_mx_mount_thickness]);
			}

			hull() 
				for( i=[0:row-1] ) translate([ row_shift[i][0],i*default_key_offset,row_shift[i][1] ] )
					for( j = [0:col-1] ) translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
						cube([default_key_offset+default_key_space,
							default_key_offset+default_key_space,
							cherry_mx_mount_thickness]);
		}

	} else {
	difference() {
			hull() for( i=[0:row-1] ) {
				translate([ row_shift[i][0],i*default_key_offset,row_shift[i][1] ] )
					for( j = [0:col-1] ) {
						translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
							cube([default_key_offset+default_key_space,
									default_key_offset+default_key_space,
									cherry_mx_mount_thickness]);
					}
			}
			translate([(default_key_offset+default_key_space)/2,(default_key_offset+default_key_space)/2,0])
				keyboard_keys(row,col,show_part = [true,true,true,true,true,true]);
		}

	}
}

if( with_support == true ) {
	rotate([180,0,0]) {
		keyboard_plate(rows,cols);

		keyboard_plate(rows,cols, true,scale_xy);
	}
} else {
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
									cherry_mx_top_thickness+cherry_mx_keycap_buffer+col_shift[j][1]+3.6 ]) 
						color("Brown") import("includes/Key_fixed.stl");
				}
		}
	
	}
}
function maximum(a, i = 0) = (i < len(a) - 1) ? max(a[i], maximum(a, i +1)) : a[i];
function maximum0(a, i = 0) = (i < len(a) - 1) ? max(a[i][0], maximum0(a, i +1)) : a[i][0];
function maximum1(a, i = 0) = (i < len(a) - 1) ? max(a[i][1], maximum0(a, i +1)) : a[i][1];