include <bolts.scad>
include <cherry_keyswitch.scad>

with_support = false;
show_keyswitches = false;
show_keycaps = false;

default_key_size = cherry_mx_outer_width;
default_key_horiz_space = 3;
default_key_vert_space = 5;

default_key_horiz_offset = default_key_size+default_key_horiz_space;
default_key_vert_offset = default_key_size+default_key_vert_space;

rows = 4;//5;
cols = 5;//6;

shift_x = 0;
shift_y = 1;
shift_z = 2;
shift_rot = 3;


row_shift = [//	[0,0,7,-20],
					[0,0,1.5,-8],
					[0,0,0,0],
					[0,0,1,6.5],
					[0,0,7,25],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0]];
col_shift = [	[0,0,3,10],
					[0,0,1,0],
					[0,4,0,0],
					[0,7,0,0],
					[0,2,2,-7],
					[0,0,3,-10],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0]];
patch_size = 1;
//col_shift = [0,0.2,0.5,0.7,0.5,0.2,0,0,0,0];
module keyboard_keys(row,col,show_parts = [true,true,false,true,false,false], show_pins = true, scale_xy = 1) {
	for( i=[0:row-1] ) {
		translate([ row_shift[i][shift_x],i*default_key_vert_offset,row_shift[i][shift_z] ] )
			for( j = [0:col-1] ) {
				translate([j*default_key_horiz_offset,col_shift[j][shift_y],col_shift[j][shift_z] ]) 
					scale([scale_xy,scale_xy,1]) 
						rotate([row_shift[i][shift_rot],0,0]) rotate([0,col_shift[j][shift_rot],0])
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
			}
	}
}

module NbyN_patch(n,x,y) {
	translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
					(default_key_vert_offset +default_key_vert_space )/2,
					cherry_mx_mount_thickness/2] )
		for( i = [max(floor(x-(n-1)/2),0):min(ceil(x+(n-1)/2),rows-1)] )
			for( j = [max(floor(y-(n-1)/2),0):min(ceil(y+(n-1)/2),cols-1)] ) 
				translate([ row_shift[i][shift_x],i*default_key_vert_offset,row_shift[i][shift_z] ] )
					translate([j*default_key_horiz_offset,col_shift[j][shift_y],col_shift[j][shift_z] ]) 
						union() {
							rotate([row_shift[i][shift_rot],0,0]) rotate([0,col_shift[j][shift_rot],0])
								cube([default_key_horiz_offset,
										default_key_vert_offset,
										cherry_mx_mount_thickness],center=true);
							translate([0,0,-cherry_mx_mount_bottom_thickness-row_shift[i][shift_z]-col_shift[j][shift_z]])
								cube([default_key_horiz_offset+default_key_horiz_space,
										default_key_vert_offset +default_key_vert_space,
										cherry_mx_mount_thickness],center = true);

						}
}

module patch_box(i,j) {
	h = -cherry_mx_mount_bottom_thickness+-row_shift[i][shift_z]-col_shift[j][shift_z];
	translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
					(default_key_vert_offset +default_key_vert_space )/2,
					cherry_mx_mount_thickness/2] )
		translate([ row_shift[i][shift_x],i*default_key_vert_offset,row_shift[i][shift_z] ] )
			translate([j*default_key_horiz_offset,col_shift[j][shift_y],col_shift[j][shift_z] ]) 
				for( o = [-1,1] ) for( p = [-1,1] ) {
					hull() {
						rotate([row_shift[i][shift_rot],0,0]) rotate([0,col_shift[j][shift_rot],0])
							translate([	o*default_key_horiz_offset/4,
											p*default_key_vert_offset /4,0])
								cube([default_key_horiz_offset/2,
										default_key_vert_offset/2,
										cherry_mx_mount_thickness],center=true);



					translate([	o*half_between(default_key_horiz_offset/2,cherry_mx_mount_width/2)+sin(col_shift[j][shift_rot])*h,
									p*half_between(default_key_vert_offset/2,cherry_mx_mount_width/2)-sin(row_shift[i][shift_rot])*h,
									h])
						cube([default_key_horiz_offset/2-cherry_mx_mount_width/2,
								default_key_vert_offset/2 -cherry_mx_mount_width/2,
								cherry_mx_mount_thickness], center = true);
//						cube([default_key_horiz_offset+default_key_horiz_space,
//								default_key_vert_offset +default_key_vert_space,
//								cherry_mx_mount_thickness],center = true);
					}//hull
				}// for( o = [-1,1] ) for( p = [-1,1] )
}

module total_patch_bottom() {
	hull() 
		translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
						(default_key_vert_offset +default_key_vert_space )/2,
						cherry_mx_mount_thickness/2] )
		for( i = [0:rows-1] )
			for( j = [0:cols-1] ) 
				translate([ row_shift[i][shift_x],i*default_key_vert_offset,row_shift[i][shift_z] ] )
					translate([j*default_key_horiz_offset,col_shift[j][shift_y],col_shift[j][shift_z] ]) 
					/*	translate([0,0,-cherry_mx_mount_bottom_thickness-row_shift[i][shift_z]-col_shift[j][shift_z]])
							cube([default_key_horiz_offset+default_key_horiz_space,
									default_key_vert_offset +default_key_vert_space,
									cherry_mx_mount_thickness],center = true);*/

				for( o = [-1,1] ) for( p = [-1,1] ) {
					translate([	o*half_between(default_key_horiz_offset/2,cherry_mx_mount_width/2)+sin(col_shift[j][shift_rot])*(-cherry_mx_mount_bottom_thickness+-row_shift[i][shift_z]-col_shift[j][shift_z]),
									p*half_between(default_key_vert_offset/2,cherry_mx_mount_width/2)-sin(row_shift[i][shift_rot])*(-cherry_mx_mount_bottom_thickness+-row_shift[i][shift_z]-col_shift[j][shift_z]),
									-cherry_mx_mount_bottom_thickness+-row_shift[i][shift_z]-col_shift[j][shift_z]])
						cube([default_key_horiz_offset/2-cherry_mx_mount_width/2,
								default_key_vert_offset/2 -cherry_mx_mount_width/2,
								cherry_mx_mount_thickness], center = true);
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
				total_patch_bottom();
				for( i=[0:rows-1] ) 
					for( j = [0:cols-1] ) {
						//NbyN_patch(patch_size,i,j);
						patch_box(i,j);
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
			translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
							(default_key_vert_offset +default_key_vert_space )/2,0])
				keyboard_keys(row,col,[true,true,true,false,true,true],false,1);
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
		translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
						(default_key_vert_offset +default_key_vert_space )/2,0])
			keyboard_keys(rows,cols);
	}
	
	if( show_keycaps == true ) {
		for( i=[0:rows-1] ) {
			translate([ row_shift[i][0]+1.5,i*default_key_vert_offset,row_shift[i][1] ] )
				for( j = [0:cols-1] ) {
					translate( [j*default_key_horiz_offset,col_shift[j][0]+1.5,
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