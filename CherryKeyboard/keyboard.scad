include <bolts.scad>
include <cherry_keyswitch.scad>

show_mirror = false;
with_support = false;
show_keyswitches = false;
show_keycaps = false;

default_key_size = cherry_mx_outer_width;
default_key_horiz_space = 5;
default_key_vert_space = 5;

default_key_horiz_offset = default_key_size+default_key_horiz_space;
default_key_vert_offset = default_key_size+default_key_vert_space;

rows = 5;//5;
cols = 7;//6;

thumb_rows = 3;
thumb_cols = 3;

shift_x = 0;
shift_y = 1;
shift_z = 2;
shift_rot = 3;


row_shift = [	[0,0,7,-20],
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
					[0,2,1,0],
					[0,10,0,0],
					[0,12,0,0],
					[0,7,1,0],
					[0,0,3,-10],
					[0,0,8,-20],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0]];

thumb_row_shift = [
					[0,0,1,0],
					[0,0,1,0],
					[0,0,4,15]];
thumb_col_shift = [	
					[0,0,2.8,10],
					[0,0,1,0],
					[0,0,2.8,-10]];

thumb_offset_x = 70;
thumb_offset_y = -50;

center_key = [3,2];
thumb_center_key = [1,1];
thumb_key_def_rot = [0,0,-30];
patch_size = 1;

key_enable = [	[1,1,1,1,1,0,0,0,0,0,0],
					[1,1,1,1,1,1,4,0,0,0,0],
					[1,1,1,1,1,1,-1,0,0,0,0],
					[1,1,1,1,1,1,5,0,0,0,0],
					[1,1,1,1,1,1,1,0,0,0,0],
					[0,0,0,0,0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0,0,0,0,0]];

thumb_key_enable = [
				[2,2,1,0,0,0,0],
				[3,3,1,0,0,0,0],
				[0,1,1,0,0,0,0],
				[0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0]];

//-1 = 1x1 blank (structure there but no keyswitch hole)
// 0 = 1x1 no key
// 1 = 1x1 key
// 2 = 1x2 key vertical (top half)
// 3 = 1x2 key vertical (bottom half)
// 4 = 1x1.5 key vertical (top half)
// 5 = 1x1.5 key vertical (bottom half)
// 6 = 2x1 key horizontal (left half)
// 7 = 2x1 key horizontal (right half)
// 8 = 1.5x1 key horizontal (left half)
// 9 = 1.5x1 key horizontal (right half)

key_width_half_table =[	[-1,default_key_horiz_offset/2],
								[0,default_key_horiz_offset/2],
								[1,default_key_horiz_offset/2],
								[2,default_key_horiz_offset/2],
								[3,default_key_horiz_offset/2],
								[4,default_key_horiz_offset/2],
								[5,default_key_horiz_offset/2],
								[6,default_key_horiz_offset],
								[7,default_key_horiz_offset],
								[8,default_key_horiz_offset/2*3],
								[9,default_key_horiz_offset/2*3]];
key_height_half_table =[[-1,default_key_horiz_offset/2],
								[0,default_key_vert_offset/2],
								[1,default_key_vert_offset/2],
								[2,default_key_vert_offset],
								[3,default_key_vert_offset],
								[4,default_key_vert_offset/2*3],
								[5,default_key_vert_offset/2*3],
								[6,default_key_vert_offset/2],
								[7,default_key_vert_offset/2],
								[8,default_key_vert_offset/2],
								[9,default_key_vert_offset/2]];

//col_shift = [0,0.2,0.5,0.7,0.5,0.2,0,0,0,0];
module keyboard_keys(row,col,row_s,col_s,enabled,show_parts = [true,true,false,true,false,false], show_pins = true, scale_xy = 1) {
	for( i=[0:row-1] ) translate( key_row_tanslation( row_s,i ) )
		for( j = [0:col-1] ) translate( key_col_tanslation( col_s,j ) ) 
			rotate([row_s[i][shift_rot],0,0]) rotate([0,col_s[j][shift_rot],0]) {
				if( enabled[i][j] == 1 ) {
					scale([scale_xy,scale_xy,1]) 
						cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}	
				if( enabled[i][j] == 2 ) {
					translate([0,default_key_vert_offset/2,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 3 ) {
					translate([0,-default_key_vert_offset/2,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 4 ) {
					translate([0,default_key_vert_offset/3,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 5 ) {
					translate([0,-default_key_vert_offset/3,0])
						scale([scale_xy,scale_xy,1]) 
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
				translate( key_row_tanslation( row_s,i ) )
					translate( key_col_tanslation( col_s,j ) ) 
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

module patch_box(i,j,row_s,col_s) {
	translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
					(default_key_vert_offset +default_key_vert_space )/2,
					cherry_mx_mount_thickness/2] )
		translate( key_row_tanslation( row_s,i ) )
			translate( key_col_tanslation( col_s,j ) )
				hull() {
					for( o = [-1,1] ) for( p = [-1,1] ) { 
						rotate([row_s[i][shift_rot],0,0]) rotate([0,col_s[j][shift_rot],0])
							translate([	o*default_key_horiz_offset/4,
											p*default_key_vert_offset /4,0])
								cube([default_key_horiz_offset/2,
										default_key_vert_offset/2,
										cherry_mx_mount_thickness],center=true);
						translate([	o*half_between(default_key_horiz_offset/2,cherry_mx_mount_width/2)+(o==1?min(sin(col_s[j][shift_rot]),0):max(sin(col_s[j][shift_rot]),0))*get_h(i,j,row_s,col_s),
										p*half_between(default_key_vert_offset/2,cherry_mx_mount_width/2)- (p==1?max(sin(row_s[i][shift_rot]),0):min(sin(row_s[i][shift_rot]),0))*get_h(i,j,row_s,col_s),
										get_h(i,j,row_s,col_s)])
						cube([default_key_horiz_offset/2-cherry_mx_mount_width/2,
								default_key_vert_offset/2 -cherry_mx_mount_width/2,
								cherry_mx_mount_thickness], center = true);
					}//hull
				}// for( o = [-1,1] ) for( p = [-1,1] )
}
function key_width_half(i,j,enable) = lookup(enable[i][j],key_width_half_table);
function key_height_half(i,j,enable) = lookup(enable[i][j],key_height_half_table);
						
						
function get_h(i,j,row_s,col_s) = (-cherry_mx_mount_bottom_thickness+-row_s[i][shift_z]-col_s[j][shift_z]);
function key_row_tanslation( row_s,i ) = [ row_s[i][shift_x],i*default_key_vert_offset,row_s[i][shift_z] ];
function key_col_tanslation( col_s,j ) = [j*default_key_horiz_offset,col_s[j][shift_y],col_s[j][shift_z] ];

module key_patch_bottom(i,j,row_s,col_s,enable) {
	if( enable[i][j] != 0 ) {
		translate( key_row_tanslation( row_s,i ) )
			translate( key_col_tanslation( col_s,j ) ) 
				for( o = [-1,1] ) for( p = [-1,1] ) {
					translate([	o*half_between(default_key_horiz_offset/2,cherry_mx_mount_width/2) + 
										sin(col_s[j][shift_rot])*get_h(i,j,row_s,col_s),
									p*half_between(default_key_vert_offset/2,cherry_mx_mount_width/2)-
										sin(row_s[i][shift_rot])*get_h(i,j,row_s,col_s),
									get_h(i,j,row_s,col_s)])
						cube([default_key_horiz_offset/2-cherry_mx_mount_width/2,
								default_key_vert_offset/2 -cherry_mx_mount_width/2,
								cherry_mx_mount_thickness], center = true);
				}
	}
}

module main_patch_bottom() {
	hull() {
		translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
							(default_key_vert_offset +default_key_vert_space )/2,
							cherry_mx_mount_thickness/2] )
			for( i = [0:rows-1] )
				for( j = [0:cols-1] ) 
					key_patch_bottom(i,j,row_shift,col_shift,key_enable);
	}
}

module thumb_patch_bottom() {
	hull() {
		translate([	center_key[0]*default_key_horiz_offset+thumb_offset_x,
						center_key[1]*default_key_vert_offset+thumb_offset_y,cherry_mx_mount_thickness/2])
			rotate(thumb_key_def_rot) 
				translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
								(default_key_vert_offset +default_key_vert_space )/2,0])
					translate([	-thumb_center_key[0]*default_key_horiz_offset,
									-thumb_center_key[1]*default_key_vert_offset,0])
						for( i = [0:thumb_rows-1] )
							for( j = [0:thumb_cols-1] ) 
								key_patch_bottom(i,j,thumb_row_shift,thumb_col_shift,thumb_key_enable);
	}
}

module total_patch_bottom() {
	hull() {
		main_patch_bottom();
		thumb_patch_bottom();
	}
}

module keyboard_main_plate() {
	union() {
		for( i=[0:rows-1] ) 
			for( j = [0:cols-1] ) if( key_enable[i][j] != 0 ) {
				patch_box(i,j,row_shift,col_shift);
			}
	}
}

module keyboard_thumb_plate() {
	translate([	center_key[0]*default_key_horiz_offset+thumb_offset_x,
					center_key[1]*default_key_vert_offset+thumb_offset_y,0])
		rotate(thumb_key_def_rot) 
			translate([	-thumb_center_key[0]*default_key_horiz_offset,
							-thumb_center_key[1]*default_key_vert_offset,0])
			for( i=[0:thumb_rows-1] ) 
				for( j = [0:thumb_cols-1] ) if( thumb_key_enable[i][j] != 0 ) {
					patch_box(i,j,thumb_row_shift,thumb_col_shift);
				}
}

module keyboard_plate() {
	difference() {
		union() {
			total_patch_bottom();
			keyboard_main_plate();
			keyboard_thumb_plate();
		}

		union() {
			translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
							(default_key_vert_offset +default_key_vert_space )/2,0])
				keyboard_keys(rows,cols,row_shift,col_shift,key_enable,
									[true,true,true,false,true,true],false,1);

			
			translate([	center_key[0]*default_key_horiz_offset+thumb_offset_x,
							center_key[1]*default_key_vert_offset+thumb_offset_y,0])
				rotate(thumb_key_def_rot) 
					translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
									(default_key_vert_offset +default_key_vert_space )/2,0])
						translate([	-thumb_center_key[0]*default_key_horiz_offset,
										-thumb_center_key[1]*default_key_vert_offset,0])
							keyboard_keys(	thumb_rows,thumb_cols,
												thumb_row_shift,thumb_col_shift,thumb_key_enable,
												[true,true,true,false,true,true],false,1);
		}
	}
}



if( with_support == true ) {
	rotate([180,0,0]) {
	//	keyboard_plate(rows,cols);

	//	keyboard_plate(rows,cols, true,0.98);
	}
} else {
	if( show_mirror== false) {
		keyboard_plate(rows,cols);
	} else {
		mirror([1,0,0])
			keyboard_plate(rows,cols);
	}
	if(show_keyswitches==true) {
		translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
						(default_key_vert_offset +default_key_vert_space )/2,0])
			color("Blue") keyboard_keys(rows,cols,row_shift,col_shift,key_enable);
		
		translate([	center_key[0]*default_key_horiz_offset+thumb_offset_x,
						center_key[1]*default_key_vert_offset+thumb_offset_y,0])
			rotate(thumb_key_def_rot) 
				translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
								(default_key_vert_offset +default_key_vert_space )/2,0])
					translate([	-thumb_center_key[0]*default_key_horiz_offset,
									-thumb_center_key[1]*default_key_vert_offset,0])
						color("Blue") keyboard_keys(	thumb_rows,thumb_cols,
											thumb_row_shift,thumb_col_shift,thumb_key_enable);
	}
	
	if( show_keycaps == true ) {
		for( i=[0:rows-1] ) {
			translate( key_row_tanslation( row_shift,i )+[1.5,0,0] )
				for( j = [0:cols-1] ) {
					translate( key_col_tanslation( col_shift,j )+[0,1.5,cherry_mx_top_thickness+cherry_mx_keycap_buffer] ) 
						rotate([row_shift[i][shift_rot],0,0]) rotate([0,col_shift[j][shift_rot],0])
							translate([0,0,3.6 ])
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
