include <bolts.scad>
include <cherry_keyswitch.scad>

with_support = false;
show_keyswitches = false;
show_keycaps = false;

default_key_size = cherry_mx_outer_width;
default_key_space = 3;

default_key_offset = default_key_size+default_key_space;

rows = 5;
cols = 6;

row_shift = [	[0,4,-10],
					[1,2,-10],
					[2,0,0],
					[3,2,5],
					[4,4,10],
					[0,0,0],
					[0,0,0],
					[0,0,0],
					[0,0,0],
					[0,0,0]];
col_shift = [	[0,2,10],
					[3,2,5],
					[5,1,0],
					[7,0,0],
					[5,1,-5],
					[2,2,-10],
					[0,0,0],
					[0,0,0],
					[0,0,0],
					[0,0,0]];

//col_shift = [0,0.2,0.5,0.7,0.5,0.2,0,0,0,0];
module keyboard_keys(row,col,show_part = [true,true,false,true,false,false], scale_xy = 1) {
	for( i=[0:row-1] ) {
		translate([ row_shift[i][0],i*default_key_offset,row_shift[i][1] ] )
			for( j = [0:col-1] ) {
				translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
					scale([scale_xy,scale_xy,1]) 
						rotate([row_shift[i][2],0,0]) rotate([0,col_shift[j][2],0])
							cherry_keyswitch(fixing_pins = true, led_pins = true, show_part = show_part);
			}
	}
}

module NbyN_patch(n,x,y) {
	hull()
		translate([	(default_key_offset+default_key_space)/2,
						(default_key_offset+default_key_space)/2,
						cherry_mx_mount_thickness/2] )
			for( i = [max(x-(n-1)/2,0):min(x+(n-1)/2,rows-1)] )
				for( j = [max(y-(n-1)/2,0):min(y+(n-1)/2,cols-1)] ) 
					translate([ row_shift[i][0],i*default_key_offset,row_shift[i][1] ] )
						translate([j*default_key_offset,col_shift[j][0],col_shift[j][1] ]) 
							hull() {
								rotate([row_shift[i][2],0,0]) rotate([0,col_shift[j][2],0])
									cube([default_key_offset+default_key_space,
											default_key_offset+default_key_space,
											cherry_mx_mount_thickness],center=true);
								translate([0,0,-row_shift[i][1]-col_shift[j][1]])
									cube([default_key_offset+default_key_space,
											default_key_offset+default_key_space,
											cherry_mx_mount_thickness],center = true);
							}
}

module keyboard_plate(row,col,make_flat = false,scale_xy ) {
	if( make_flat == true ) {
	/*	intersection() {
			translate([0,0,max(maximum1(row_shift),maximum1(col_shift))]) scale([1,1,-1])
				cube([default_key_offset*col+default_key_space+maximum0(row_shift),
						default_key_offset*row+default_key_space+maximum0(col_shift),
						cherry_mx_mount_thickness+5]);
			translate([(default_key_offset+default_key_space)/2,(default_key_offset+default_key_space)/2,0])
				keyboard_keys(row,col,[true,false,false,false,true,false],scale_xy);
		}
*/
	} else {
		difference() {
			union() {
				for( i=[0:rows-1] ) 
					for( j = [0:cols-1] ) {
						NbyN_patch(3,i,j);
					}
	
//				hull() translate([0,0,min(minimum1(row_shift),minimum1(col_shift))]) hull() for( i=[0:row-1] ) {
//					translate([ row_shift[i][0],i*default_key_offset,0 ] )
//						for( j = [0:col-1] ) {
//							translate([j*default_key_offset,col_shift[j][0],0 ]) 
//								cube([default_key_offset+default_key_space,
//										default_key_offset+default_key_space,
//										cherry_mx_mount_thickness]);
//						}
//				}
			}
			translate([(default_key_offset+default_key_space)/2,(default_key_offset+default_key_space)/2,0])
				keyboard_keys(row,col,show_part = [true,true,true,false,true,true]);
		}

	}
}

if( with_support == true ) {
	rotate([180,0,0]) {
	//	keyboard_plate(rows,cols);

	//	keyboard_plate(rows,cols, true,0.98);
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
									cherry_mx_top_thickness+cherry_mx_keycap_buffer+col_shift[j][1]]) rotate([row_shift[i][2],0,0]) rotate([0,col_shift[j][2],0]) translate([0,0,3.6 ])
						color("Brown") import("includes/Key_fixed.stl");
				}
		}
	
	}
}
function maximum(a, i = 0) = (i < len(a) - 1) ? max(a[i], maximum(a, i +1)) : a[i];
function maximum0(a, i = 0) = (i < len(a) - 1) ? max(a[i][0], maximum0(a, i +1)) : a[i][0];
function maximum1(a, i = 0) = (i < len(a) - 1) ? max(a[i][1], maximum0(a, i +1)) : a[i][1];
function minimum(a, i = 0) = (i < len(a) - 1) ? min(a[i], maximum(a, i +1)) : a[i];
function minimum0(a, i = 0) = (i < len(a) - 1) ? min(a[i][0], minimum0(a, i +1)) : a[i][0];
function minimum1(a, i = 0) = (i < len(a) - 1) ? min(a[i][1], minimum0(a, i +1)) : a[i][1];