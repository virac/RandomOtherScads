include <bolts.scad>
include <cherry_keyswitch.scad>
use <keyboard2.scad>

show_plate = true ;
show_base = false ;
show_top = false ;

split_parts = false ;

show_mirror = false ;
with_main = true ;
with_thumb = true ;
with_func = true ;
with_support = false ;

show_keyswitches = false ;
show_keycaps = false ;
show_screws = true ;
show_support = false ;

stilts = false;
attach_vert = true;
attach_hoiz = true;
attach_corner = true;

standoff_thickness = 7;

default_key_size = cherry_mx_outer_width;
default_key_horiz_space = 4;
default_key_vert_space = 4;

default_key_horiz_offset = default_key_size+default_key_horiz_space;
default_key_vert_offset = default_key_size+default_key_vert_space;

center_key = [4,2];
thumb_center_key = [1,1];
thumb_key_def_rot = [0,0,-40];

center_key_offset = [	
					center_key[0]*default_key_horiz_offset,
					center_key[1]*default_key_vert_offset,0];

thumb_offset = center_key_offset + [73,5,0];

func_offset = center_key_offset + [-60,145,0];

func_center_key = [0,3];
func_key_def_rot = [0,0,2.5];

patch_size = 1;

row_shift = [	
				[0,0,0,0,0],
				[0,0.5,0,0,0],
				[0,0,0,0,0],
				[0,0.5,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0], //not used
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0]];
col_shift = [	
				[0,10,0,0,0],
				[0,0,0,0,0],
				[0,2,0,0,0],
				[0,10,0,0,0],
				[0,16,0,0,0],
				[0,12,0,0,0],
				[0,12,0,0,0], //	[0,0,22,-20],
				[0,12,0,0,0], //	[0,0,32,-24],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0]];

thumb_row_shift = [
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0] ];
thumb_col_shift = [	
				[0,-5,0,0,20], //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!40
				[5,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0] ];
				
				
func_row_shift = [
				[0,8,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0]];
func_col_shift = [	
				[0,-3.5,0,0,10], //1
				[0,0,0,0,10],
				[8,4,0,0,0],	
				[0,4,0,0,0],
				[8,0,0,0,-10],
				[0,-3.5,0,0,-10],//6
				[0,0,0,0,0],
				[0,0,0,0,0]
				];

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
//10 = 1x1 key in bottom of 1x1.5 slot

rows_0 = 0 ;
cols_0 = 0 ;
rows = 6;//5;
cols = 8;//8;//6;

key_enable = [					
				[0,0,0,1,0,0,0,0,0,0,0],
				[0,0,1,1,10,5,0,0,0,0,0],
				[0,9,1,1,1,1,1,4,0,0,0],
				[5,1,1,1,1,1,1,0,0,0,0],
				[1,1,1,1,1,1,1,5,0,0,0],
				[0,1,1,1,1,1,1,1,0,0,0],
				[0,1,1,1,1,1,1,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0]];

thumb_rows_0 = 0 ;
thumb_cols_0 = 0 ;
thumb_rows = 3;
thumb_cols = 3;
thumb_key_enable = [
				[5,5,5,0,0,0,0],
				[0,1,1,0,0,0,0],
				[0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0]];

func_rows_0 = 0 ;
func_cols_0 = 0 ;
func_rows = 1;
func_cols = 6;

func_key_enable = [
				[1,1,1,1,1,1,1,0,0],
				[0,0,0,0,0,0,0,0,0]];

linked_thumb_keys	= [
				[7,2],[1,1],
				[6,2],[1,1],
				[5,2],[1,1],
				[5,1],[1,1]];
//				[,],[,]];

linked_func_keys	= [
				[1,5],[0,0],
				[2,5],[0,0],
				[2,5],[0,1],
				[3,5],[0,1],
				[3,5],[0,2],
				[4,5],[0,2],
				[4,5],[0,3],
				[5,5],[0,3],
				[5,5],[0,4],
				[6,5],[0,4],
				[6,5],[0,5],
				[7,5],[0,5]
				
				];
				
screw_hole_offset = [ //x,y,rot
				[1,2,0],
				[4,2,0],
				[0.9,4,0],
				[4,4,0],
				[1.2,7.2,0],
				[4.05,7.0,90]
			//	,[1.15,7.95,0],
			//	[3.9,7.95,0]
		/*		,
				[6.1,2.8,0],
				[6.1,5.2,0]*/ ];

thumb_screw_hole_offset = [
				[0.3,1,0],
				[1.8,0.87,0],
				[1,2.95,0],
				[2.0,2.95,0] ];
				
func_screw_hole_offset = [
				[0.05,0,0],
				[0.25,3,0],
				[0.05,6.2,0] ];
			

								
if( show_mirror== false) {
	if( show_base == true ) {
		keyboard_bottom();
	}
	if( show_plate == true ) {
		if( split_parts == true ) {
			difference() {
				translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws, linked_thumb_keys, linked_func_keys,
									rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,[0,0,0],[0,0,0],[0,0],
									thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,thumb_offset,thumb_key_def_rot,thumb_center_key,
									func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,func_offset,func_key_def_rot,func_center_key);
				translate([ 5.2*default_key_horiz_offset,
						-3*default_key_vert_offset,
						-20] ) cube(220);
			}
		} else {
			translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws, linked_thumb_keys, linked_func_keys,
									rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,[0,0,0],[0,0,0],[0,0],
									thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,thumb_offset,thumb_key_def_rot,thumb_center_key,
									func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,func_offset,func_key_def_rot,func_center_key);
		}
	}
	if( show_top == true ) {
		translate([0,0,cherry_mx_mount_thickness/2])
			keyboard_top();
	}
} else {
	mirror([1,0,0]){
		if( show_base == true ) {
			keyboard_bottom();
		}
		if( show_plate == true ) {
			if( split_parts == true ) {
				intersection() {
					translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws, linked_thumb_keys, linked_func_keys,
										rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,[0,0,0],[0,0,0],[0,0],
										thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,thumb_offset,thumb_key_def_rot,thumb_center_key,
										func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,func_offset,func_key_def_rot,func_center_key);
					translate([ 5.1*default_key_horiz_offset,
							-3*default_key_vert_offset,
							-20] ) cube(220);
				}
			} else {
				translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws, linked_thumb_keys, linked_func_keys,
									rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,[0,0,0],[0,0,0],[0,0],
									thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,thumb_offset,thumb_key_def_rot,thumb_center_key,
									func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,func_offset,func_key_def_rot,func_center_key);
			}
		}
	}
}
if(show_keyswitches==true) translate([0,0,standoff_thickness+cherry_mx_mount_thickness]) {
	if( with_main == true )
		//translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
		//			(default_key_vert_offset +default_key_vert_space )/2,0])
			color("Blue") keyboard_key(rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable);
	
	if( with_thumb == true )
		translate( thumb_offset )
			rotate(thumb_key_def_rot) 
		//		translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
		//					(default_key_vert_offset +default_key_vert_space )/2,0])
					translate([	-thumb_center_key[0]*default_key_horiz_offset,
								-thumb_center_key[1]*default_key_vert_offset,0])
						color("Blue") keyboard_key(	thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,
										thumb_row_shift,thumb_col_shift,thumb_key_enable);
	if( with_func == true )
		translate( func_offset )
			rotate(func_key_def_rot) 
		//		translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
		//					(default_key_vert_offset +default_key_vert_space )/2,0])
					translate([	-func_center_key[0]*default_key_horiz_offset,
								-func_center_key[1]*default_key_vert_offset,0])
						color("Blue") keyboard_key(func_rows_0,func_rows,func_cols_0,func_cols,
										func_row_shift,func_col_shift,func_key_enable);
}

if( show_keycaps == true ) translate([0,0,standoff_thickness+cherry_mx_mount_thickness]){
		if( with_main == true )
	translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
					(default_key_vert_offset +default_key_vert_space )/2,0])
		color("Brown") keyboard_keycap(rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable);

		if( with_thumb == true )
	translate( thumb_offset )
		rotate(thumb_key_def_rot) 
			translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
							(default_key_vert_offset +default_key_vert_space )/2,0])
				translate([	-thumb_center_key[0]*default_key_horiz_offset,
								-thumb_center_key[1]*default_key_vert_offset,0])
					color("Brown") keyboard_keycap(thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,
										thumb_row_shift,thumb_col_shift,thumb_key_enable);
		
		if( with_func == true )
	translate( func_offset )
		rotate(func_key_def_rot) 
			translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
							(default_key_vert_offset +default_key_vert_space )/2,0])
				translate([	-func_center_key[0]*default_key_horiz_offset,
								-func_center_key[1]*default_key_vert_offset,0])
					color("Brown") keyboard_keycap(func_rows_0,func_rows,func_cols_0,func_cols,
										func_row_shift,func_col_shift,func_key_enable);
	// for( i=[0:rows-1] ) {
		// translate( key_row_translation( row_shift,i )+[1.5,0,0] )
			// for( j = [0:cols-1] ) {
				// translate( key_col_translation( col_shift,j )+[0,1.5,cherry_mx_top_thickness+cherry_mx_keycap_buffer] ) 
					// rotate([row_shift[i][shift_rot],0,0]) rotate([0,col_shift[j][shift_rot],0])
						// translate([0,0,3.6 ])
							// color("Brown") import("includes/Key_fixed.stl");
			// }
	//}

}