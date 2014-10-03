include <bolts.scad>
include <cherry_keyswitch.scad>

show_plate = true;
show_base = false;
show_top = false;

split_parts = false;

show_mirror = false;
with_main = true;
with_thumb = false;
with_func = false;
with_support = false;

show_keyswitches = false;
show_keycaps = false;
show_screws = true;
show_support = false;

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

rows_0 = 0 ;
cols_0 = 1 ;
rows = 5;//5;
cols = 8;//8;//6;

thumb_rows_0 = 0 ;
thumb_cols_0 = 0 ;
thumb_rows = 3;
thumb_cols = 3;

func_rows_0 = 0 ;
runc_cols_0 = 0 ;
func_rows = 1;
func_cols = 6;

shift_x = 0;
shift_y = 1;
shift_z = 2;
shift_rot = 3;


row_shift = [	
				[0,0,7,-20],
				[0,0.5,2.5,-8],
				[0,0,0,0],
				[0,0.5,2,11],
				[0,2,10,33],
				[0,4,15,0], //not used
				[0,0,0,0],
				[0,0,0,0],
				[0,0,0,0],
				[0,0,0,0]];
col_shift = [	
				[0,0,0,-10],//not used
				[0,0,7,15],
				[2,2,3,0],
				[0,10,2,-4],
				[0,12,0,-8],
				[0,7,7,-16],
				[0,0,17,-20], //	[0,0,22,-20],
				[0,0,30,-34], //	[0,0,32,-24],
				[0,0,0,0],
				[0,0,0,0],
				[0,0,0,0]];

thumb_row_shift = [
				[0,0,2,0],
				[0,0,2,0],
				[0,0,5,15],
				[0,0,0,0] ];
thumb_col_shift = [	
				[0,0,15,40], //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!40
				[5,0,2,0],
				[0,0,3.8,-10],
				[0,0,0,0] ];
				
				
func_row_shift = [
				[0,8,15,0],
				[0,0,0,0],
				[0,0,0,0]];
func_col_shift = [	
				[0,0,0,0], //1
				[0,3,0,0],
				[0,4,0,0],	
				[0,6,1,0],
				[0,1,3,0],
				[0,0,8,0],//6
				[0,0,0,0],
				[0,0,0,0]
				];


center_key = [4,2];
thumb_center_key = [1,1];
thumb_key_def_rot = [0,0,-35];

center_key_offset = [	center_key[0]*default_key_horiz_offset,
					center_key[1]*default_key_vert_offset,0];

thumb_offset = center_key_offset + [80,-50,0];

func_offset = center_key_offset + [-63,135,0];

func_center_key = [0,3];
func_key_def_rot = [0,0,0];

patch_size = 1;

key_enable = [	
			 /*    [0,0,0,0,0,0,0,0,0,0],
				[0,0,0,1,0,1,4,0,0,0],
				[0,0,0,0,0,1,0,0,0,0],
				[0,0,0,0,0,1,5,0,0,0],
				[0,0,0,0,0,1,1,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0]];*/
				
				[0,1,1,1,1,1,0,0,0,0,0],
				[0,9,1,1,1,1,1,4,0,0,0],
				[0,9,1,1,1,1,1,0,0,0,0],
				[0,9,1,1,1,1,1,5,0,0,0],
				[0,9,1,1,1,1,1,1,0,0,0],
				[0,1,1,1,1,1,1,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0,0]];

thumb_key_enable = [
				[2,2,1,0,0,0,0],
				[0,0,1,0,0,0,0],
				[0,1,1,0,0,0,0],
				[0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0]];
				

func_key_enable = [
				[1,1,1,1,1,1,1],
				[0,0,0,0,0,0,0]];

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
				[0.05,-0.2,0],
				[0.25,3,0],
				[0.05,6.2,0] ];
				
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

base_offset = [	(default_key_horiz_offset+default_key_horiz_space)/2,
					(default_key_vert_offset +default_key_vert_space )/2,
					cherry_mx_mount_thickness/2];
key_width_part_def = default_key_horiz_offset/2;
								//key,p,non_default value
key_width_part_table = [	[6,[[-1,default_key_horiz_offset],
								[ 0,default_key_horiz_offset/2],
								[ 1,default_key_horiz_offset]]],
							[7,[[-1,default_key_horiz_offset],
								[ 0,-default_key_horiz_offset/2],
								[ 1,default_key_horiz_offset]]],
							[8,[[-1,default_key_horiz_offset*3/4],
								[ 0,default_key_horiz_offset/4],
								[ 1,default_key_horiz_offset*3/4]]],
							[9,[[-1,default_key_horiz_offset*3/4],
								[ 0,-default_key_horiz_offset/4],
								[ 1,default_key_horiz_offset*3/4]]] ];


key_height_part_def = default_key_vert_offset/2;
								//key,o,non_default value
key_height_part_table = [	[2,[[-1,default_key_vert_offset],
								[ 0,default_key_vert_offset/2],
								[ 1,default_key_vert_offset]]],
							[3,[[-1,default_key_vert_offset],
								[ 0,-default_key_vert_offset/2],
								[ 1,default_key_vert_offset]]],
							[4,[[-1,default_key_vert_offset*3/4],
								[ 0,default_key_vert_offset/4],
								[ 1,default_key_vert_offset*3/4]]],
							[5,[[-1,default_key_vert_offset*3/4],
								[ 0,-default_key_vert_offset/4],
								[ 1,default_key_vert_offset*3/4]]] ];

//v = find( 3,key_height_part_table,default_key_vert_offset/2);
//echo("vec v=",v);
//echo(find(-1,[v],default_key_vert_offset/2));

// 1 = 1x1 key
// 2 = 1x2 key vertical (top half)
// 3 = 1x2 key vertical (bottom half)
// 4 = 1x1.5 key vertical (top half)
// 5 = 1x1.5 key vertical (bottom half)
// 6 = 2x1 key horizontal (left half)
// 7 = 2x1 key horizontal (right half)
// 8 = 1.5x1 key horizontal (left half)
// 9 = 1.5x1 key horizontal (right half)
//col_shift = [0,0.2,0.5,0.7,0.5,0.2,0,0,0,0];
module keyboard_key(row_0,row_n,col_0,col_n,row_s,col_s,enabled,show_parts = [true,true,false,true,false,false], show_pins = true, scale_xy = 1) {
	for( i=[row_0:row_n-1] ) for( j = [col_0:col_n-1] ) 
		translate( base_offset + key_translation( i, j, row_s, col_s ) ) 
			rotate([0,col_s[j][shift_rot],0]) rotate([row_s[i][shift_rot],0,0]) {
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
					translate([0,default_key_vert_offset/4,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 5 ) {
					translate([0,-default_key_vert_offset/4,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 6 ) {
					translate([default_key_vert_offset/2,0,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 7 ) {
					translate([-default_key_vert_offset/2,0,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 8 ) {
					translate([default_key_vert_offset/4,0,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}
				if( enabled[i][j] == 9 ) {
					translate([-default_key_vert_offset/4,0,0])
						scale([scale_xy,scale_xy,1]) 
							cherry_keyswitch(fixing_pins = show_pins, led_pins = show_pins, switch_pins = show_pins, show_part = show_parts);
				}

				translate([ key_part(i,j,0,enabled,key_width_part_table,0),
							key_part(i,j,0,enabled,key_height_part_table,0),
							0]) //shift to center
					for( o = [-1,1] ) for( p = [-1,1] )
						translate([	o*key_part(i,j,o,enabled,key_width_part_table,key_width_part_def)/2,
									p*key_part(i,j,p,enabled,key_height_part_table,key_height_part_def)/2,
									cherry_mx_mount_thickness/2.0 + (cherry_mx_mount_thickness*2)/2])
							cube([key_part(i,j,o,enabled,key_width_part_table,key_width_part_def),
								key_part(i,j,p,enabled,key_height_part_table,key_height_part_def),
								cherry_mx_mount_thickness*2], center = true);
			}
}


module keyboard_keycap(row_0,row_n,col_0,col_n,row_s,col_s,enabled,show_parts = [true,true,false,true,false,false], show_pins = true, scale_xy = 1) {
	for( i=[row_0:row_n-1] ) 
		for( j = [col_0:col_n-1] ) translate( key_translation( i, j, row_s, col_s ) ) 
			rotate([0,col_s[j][shift_rot],0]) rotate([row_s[i][shift_rot],0,0]) translate([-9,-9,1.6+cherry_mx_top_thickness+cherry_mx_keycap_buffer]) {//3.6
				if( enabled[i][j] == 1 ) {
					scale([scale_xy,scale_xy,1]) 
						import("includes/Key_fixed.stl");
				}	
				if( enabled[i][j] == 2 ) {
					translate([0,0,0])
						scale([scale_xy,scale_xy*2,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 3 ) {
					translate([0,-default_key_vert_offset,0])
						scale([scale_xy,scale_xy*2,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 4 ) {
					translate([0,0,0])
						scale([scale_xy,scale_xy*1.5,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 5 ) {
					translate([0,-default_key_vert_offset/2,0])
						scale([scale_xy,scale_xy*1.5,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 6 ) {
					translate([0,0,0])
						scale([scale_xy*2,scale_xy,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 7 ) {
					translate([-default_key_vert_offset,0,0])
						scale([scale_xy*2,scale_xy,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 8 ) {
					translate([default_key_vert_offset/4,0,0])
						scale([scale_xy,scale_xy,1]) 
							import("includes/Key_fixed.stl");
				}
				if( enabled[i][j] == 9 ) {
					translate([-default_key_vert_offset/2,0,0])
						scale([scale_xy*1.5,scale_xy,1]) 
							import("includes/Key_fixed.stl");
				}
			}
}
module NbyN_patch(n,x,y) {
	translate([	(default_key_horiz_offset+default_key_horiz_space)/2,
					(default_key_vert_offset +default_key_vert_space )/2,
					cherry_mx_mount_thickness/2] )
		for( i = [max(floor(x-(n-1)/2),0):min(ceil(x+(n-1)/2),rows-1)] )
			for( j = [max(floor(y-(n-1)/2),0):min(ceil(y+(n-1)/2),cols-1)] ) 
				translate( key_translation( i,j,row_s,col_s ) ) 
						union() {
							rotate([0,col_shift[j][shift_rot],0])rotate([row_shift[i][shift_rot],0,0]) 
								cube([default_key_horiz_offset,
										default_key_vert_offset,
										cherry_mx_mount_thickness],center=true);
							translate([0,0,-cherry_mx_mount_bottom_thickness-row_shift[i][shift_z]-col_shift[j][shift_z]])
								cube([default_key_horiz_offset+default_key_horiz_space,
										default_key_vert_offset +default_key_vert_space,
										cherry_mx_mount_thickness],center = true);
						}
}

module face_part( i,j,o,p,row_s,col_s,enable,thickness,enlarge=1.0,extend = 0.0) {
	rotate([0,col_s[j][shift_rot],0])rotate([row_s[i][shift_rot],0,0]) 
		translate([ key_part(i,j,0,enable,key_width_part_table,0),
					key_part(i,j,0,enable,key_height_part_table,0),
					0]) //shift to center
			translate([	o*key_part(i,j,o,enable,key_width_part_table,key_width_part_def)/2,
						p*key_part(i,j,p,enable,key_height_part_table,key_height_part_def)/2,-0.5])
				cube([key_part(i,j,o,enable,key_width_part_table,key_width_part_def) * enlarge,
						key_part(i,j,p,enable,key_height_part_table,key_height_part_def) * enlarge,
						thickness+1.0],center=true);
}

module face_part_sliver( i,j,o,p,row_s,col_s,enable,thickness,piece=0) {
	if( i > -1 && i < rows && j > -1 && j < cols && enable[i][j] != 0 ) {
		translate( key_translation( i, j, row_s, col_s ) )
			rotate([0,col_s[j][shift_rot],0]) rotate([row_s[i][shift_rot],0,0])
				translate([ key_part(i,j,0,enable,key_width_part_table,0),
							key_part(i,j,0,enable,key_height_part_table,0),
							0]) {//shift to center 
					if( piece == 1 ) 
						translate([	o*(key_part(i,j,o,enable,key_width_part_table,key_width_part_def)/2),
									p*(key_part(i,j,p,enable,key_height_part_table,key_height_part_def)-0.05),-1.0])
							cube([key_part(i,j,o,enable,key_width_part_table,key_width_part_def), 0.1, thickness],center=true);
					if( piece == 2 ) 
						translate([	o*(key_part(i,j,o,enable,key_width_part_table,key_width_part_def)-0.05),
									p*(key_part(i,j,p,enable,key_height_part_table,key_height_part_def)/2),-1.0])
							cube([0.1, key_part(i,j,p,enable,key_height_part_table,key_height_part_def), thickness],center=true);
					if( piece == 3 ) 
						translate([	o*(key_part(i,j,o,enable,key_width_part_table,key_width_part_def)-0.05),
									p*(key_part(i,j,p,enable,key_height_part_table,key_height_part_def)-0.05),-1.0])
							cube([0.1, 0.1, thickness],center=true);
				}
	}
}

module base_part_sliver( i,j,o,p,row_s,col_s,enable,thickness) {
	//if( i > -1 && i < rows && j > -1 && j < cols && enable[i][j] != 0 ) {
//		translate( key_translation( i,j,row_s,col_s ) )
	//		base_part( i,j,o,p,row_s,col_s,enable,thickness);
	//}
}

module base_part( i,j,o,p,row_s,col_s,enable,thickness) {
	translate([ key_part(i,j,0,enable,key_width_part_table,0),
				key_part(i,j,0,enable,key_height_part_table,0),
				0]) //shift to center
		hull() {
			translate([	o*half_between(key_part(i,j,o,enable,key_width_part_table,key_width_part_def),cherry_mx_mount_width/2)+
							sin(col_s[j][shift_rot])*(-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s)),
						p*cos(row_s[i][shift_rot])*half_between(key_part(i,j,p,enable,key_height_part_table,key_height_part_def),cherry_mx_mount_width/2)-
							tan(row_s[i][shift_rot])*((-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s))/cos(col_s[j][shift_rot])),
						get_h(i,j,row_s,col_s)])
				cube([key_part(i,j,o,enable,key_width_part_table,key_width_part_def)-cherry_mx_mount_width/2,
					key_part(i,j,p,enable,key_height_part_table,key_height_part_def) -cherry_mx_mount_width/2,
					thickness], center = true);
			//this is here so the boxes are at least vertical and no overhang
			translate([	o*half_between(key_part(i,j,o,enable,key_width_part_table,key_width_part_def),cherry_mx_mount_width/2)+
							(o==1?min(sin(col_s[j][shift_rot]),0):max(sin(col_s[j][shift_rot]),0))*(-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s)),
						p*half_between(key_part(i,j,p,enable,key_height_part_table,key_height_part_def),cherry_mx_mount_width/2)-
							(p==1?max(tan(row_s[i][shift_rot]),0):min(tan(row_s[i][shift_rot]),0))*(-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s)/cos(col_s[j][shift_rot])),
						get_h(i,j,row_s,col_s)])
				cube([key_part(i,j,o,enable,key_width_part_table,key_width_part_def)-cherry_mx_mount_width/2,
					key_part(i,j,p,enable,key_height_part_table,key_height_part_def) -cherry_mx_mount_width/2,
					thickness], center = true);

		}
}

module patch_top(i,j,row_s,col_s,enable,thickness,enlargement,extend) {
	sliver_shift =  key_translation( i, j, row_s, col_s );
	translate( base_offset + sliver_shift ) union() {
		hull() {
			for( o = [-1,1] ) for( p = [-1,1] ) { 
				face_part( i,j,o,p,row_s,col_s,enable,thickness,enlargement,extend);
			//	base_part( i,j,o,p,row_s,col_s,enable,thickness);
			}// for( o = [-1,1] ) for( p = [-1,1] )
		}//hull
	}
}

module patch_set(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness) {
	for( i = [row_0:row_n-1] )
		for( j = [col_0:col_n-1] )  if( enable[i][j] != 0 ) {
			patch_box(i,j,row_s,col_s,enable,thickness);
		}
}

module patch_box(i,j,row_s,col_s,enable,thickness) {
	sliver_shift =  key_translation( i, j, row_s, col_s );
	translate( base_offset ) {
		union() {
			for( o = [-1,1] ) for( p = [-1,1] ) {
				//colums are solid]
				if( attach_vert == true ) hull() {
					face_part_sliver( i  ,j  ,o, p,row_s,col_s,enable,thickness,1);
					 // if current is 1x1.5 bottom and 2 above is 1x1.5 top, asumes 1 above is empty
					if(        p == 1 && enable[i][j] == 4 && enable[i+2][j] == 5) {
						face_part_sliver( i+2,j  ,o,-p,row_s,col_s,enable,thickness,1);
					} else if( p ==-1 && enable[i][j] == 5 && enable[i-2][j] == 4)  {// if 1x1.5 top and -2 is bottom
						face_part_sliver( i-2,j  ,o,-p,row_s,col_s,enable,thickness,1);
					} else if( p == 1 && enable[i][j] == 2 && enable[i+2][j] != 0)  {// if 1x2 bottom and +2 is non null
						face_part_sliver( i+2,j  ,o,-p,row_s,col_s,enable,thickness,1);
					} else if( p ==-1 && enable[i][j] == 3 && enable[i-2][j] != 0)  {// if 1x2 top and -1 is non null
						face_part_sliver( i-2,j  ,o,-p,row_s,col_s,enable,thickness,1);
					} else {
						face_part_sliver( i+p,j  ,o,-p,row_s,col_s,enable,thickness,1);
					}
				}					
				//rows are solid
				if( attach_hoiz == true ) hull() {
					face_part_sliver( i  ,j  , o, p,row_s,col_s,enable,thickness,2);
					
					if(        o == 1 && enable[i][j] == 8 && enable[i][j+2] == 9) {
						face_part_sliver( i,j+2,o,-p,row_s,col_s,enable,thickness,2);
					} else if( o ==-1 && enable[i][j] == 9 && enable[i][j-2] == 8)  {
						face_part_sliver( i,j-2,o,-p,row_s,col_s,enable,thickness,2);
					} else if( o == 1 && enable[i][j] == 6 && enable[i][j+2] != 0)  {
						face_part_sliver( i,j+2,o,-p,row_s,col_s,enable,thickness,2);
					} else if( o ==-1 && enable[i][j] == 7 && enable[i][j-2] != 0)  {
						face_part_sliver( i,j-2,o,-p,row_s,col_s,enable,thickness,2);
					} else {
						face_part_sliver( i  ,j+o,-o, p,row_s,col_s,enable,thickness,2);
					}
					
					if( o == 1 && enable[i][j] == 1 && enable[i-1][j+1] == 4)  {
						face_part_sliver( i-1,j+1,-o,p,row_s,col_s,enable,thickness,3);
					}
					if( o == 1 && enable[i][j] == 1 && enable[i+1][j+1] == 5)  {
						face_part_sliver( i+1,j+1,-o,p,row_s,col_s,enable,thickness,3);
					} 
				}			
				//corners are attached
				if( attach_corner == true ) hull() {
					face_part_sliver( i  ,j  , o, p,row_s,col_s,enable,thickness,3);
					face_part_sliver( i  ,j+o,-o, p,row_s,col_s,enable,thickness,3);
					face_part_sliver( i+p,j  , o,-p,row_s,col_s,enable,thickness,3);
					face_part_sliver( i+p,j+o,-o,-p,row_s,col_s,enable,thickness,3);
				}
			}
		}
		translate(sliver_shift) hull() {
			for( o = [-1,1] ) for( p = [-1,1] ) { 
				face_part( i,j,o,p,row_s,col_s,enable,thickness);
		//		base_part( i,j,o,p,row_s,col_s,enable,thickness);
			}// for( o = [-1,1] ) for( p = [-1,1] )
		}//hull
	}
}

module key_patch_bottom(i,j,row_s,col_s,enable,thickness) {
	if( enable[i][j] != 0 ) hull() {
		translate( key_translation( i,j,row_s,col_s ) ) 
			for( o = [-1,1] ) for( p = [-1,1] ) {
				translate([ key_part(i,j,0,enable,key_width_part_table,0),
							key_part(i,j,0,enable,key_height_part_table,0),
							0]) 
					{//shift to center
					translate([	o*half_between(key_part(i,j,o,enable,key_width_part_table,key_width_part_def),cherry_mx_mount_width/2)+
								0,//	sin(col_s[j][shift_rot])*(-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s)),
								p*cos(row_s[i][shift_rot])*half_between(key_part(i,j,p,enable,key_height_part_table,key_height_part_def),cherry_mx_mount_width/2)-
								0,//	tan(row_s[i][shift_rot])*((-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s))/cos(col_s[j][shift_rot])),
								get_h(i,j,row_s,col_s)])
						cube([key_part(i,j,o,enable,key_width_part_table,key_width_part_def)-cherry_mx_mount_width/2,
							key_part(i,j,p,enable,key_height_part_table,key_height_part_def) -cherry_mx_mount_width/2,
							thickness], center = true);
					translate([	o*half_between(key_part(i,j,o,enable,key_width_part_table,key_width_part_def),cherry_mx_mount_width/2)+
								0,//	(o==1?min(sin(col_s[j][shift_rot]),0):max(sin(col_s[j][shift_rot]),0))*(-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s)),
								p*half_between(key_part(i,j,p,enable,key_height_part_table,key_height_part_def),cherry_mx_mount_width/2)-
								0,//	(p==1?max(tan(row_s[i][shift_rot]),0):min(tan(row_s[i][shift_rot]),0))*(-cherry_mx_mount_bottom_thickness+get_h(i,j,row_s,col_s)/cos(col_s[j][shift_rot])),
								get_h(i,j,row_s,col_s)])
						cube([key_part(i,j,o,enable,key_width_part_table,key_width_part_def)-cherry_mx_mount_width/2,
							key_part(i,j,p,enable,key_height_part_table,key_height_part_def) -cherry_mx_mount_width/2,
							thickness], center = true);
				}
			}
	}
}

//*******************************************************************
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1!!
//*******************************************************************
module keyboard_screws(hole_offset,row_s,col_s,enable, offset = [0,0,0], key_rot = [0,0,0], center_key = [0,0]) {
	translate( offset )
		rotate(key_rot)
			translate([	-center_key[0]*default_key_horiz_offset,
						-center_key[1]*default_key_vert_offset,0]) { 
				union() {
					for( i=[0:len(hole_offset)-1] )
						translate( screw_trans( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +
									[default_key_horiz_space/2,default_key_vert_space/2,0])  {
							rotate([0,0,hole_offset[i][2]])
								cylinder( r = m3_nut_diameter/2, h = 60, $fn = 6 );
							translate([0,0,-standoff_thickness-0.1])	{
								cylinder( r = m3_diameter/2, h = 60, $fn = 30 ); // hole
								cylinder( r1 = m3_diameter, r2 = m3_diameter/2, h = cherry_mx_mount_thickness, $fn = 30 );
							}
							translate([0,0,m3_nut_thickness])	{
								//cylinder( r = m3_nut_diameter*5/7, h = 30);
							}
						}
				}
	}
}

module keyboard_screw_mounts(hole_offset,row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness ) {
	union() for( i=[0:len(hole_offset)-1] ) {
		hull() {
			translate( screw_trans( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +
						[default_key_horiz_space/2,default_key_vert_space/2,-standoff_thickness])  {
				cylinder( r = m3_nut_diameter*3/4, h = cherry_mx_mount_thickness+standoff_thickness );//cherry_mx_mount_bottom_thickness+m3_nut_thickness );
			}
//TODO Add here for terminal supportsy thing
			intersection() {
				patch_set( //row_0,row_n,col_0,col_n,
							max(floor(hole_offset[i][0])-1,row_0),min(ceil(hole_offset[i][0])+1,row_n),
							max(floor(hole_offset[i][1])-1,col_0),min(ceil(hole_offset[i][1])+1,col_n),
							row_s,col_s,enable,thickness/2);
				translate( screw_trans( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +
							[default_key_horiz_space/2,default_key_vert_space/2,-cherry_mx_mount_bottom_thickness])  {
					cylinder( r = m3_nut_diameter*3/4, h = 60 );//cherry_mx_mount_bottom_thickness+m3_nut_thickness );
				}
			}
		}
	}
}

module screw_patch_bottom(hole_offset,row_s,col_s,enable,thickness ) {
	hull() {
		for( i=[0:len(hole_offset)-1] )
			translate( screw_trans( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +
						[default_key_horiz_space/2,default_key_vert_space/2,-cherry_mx_mount_bottom_thickness+cherry_mx_mount_thickness/2-thickness/2])  {
				cylinder( r = m3_nut_diameter*3/4, h = thickness );
			}
	}
}

module patch_bottom(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset,offset = [0,0,0],key_rot = [0,0,0],center_key = [0,0]) {
	hull() {
		translate(offset )
			rotate(key_rot) 
				translate([	-center_key[0]*default_key_horiz_offset,
							-center_key[1]*default_key_vert_offset,0]) {
					translate(base_offset)
						for( i = [row_0:row_n-1] )
							for( j = [col_0:col_n-1] ) if( isBorder(i,j,row_n-1,col_n-1,enable) )
								key_patch_bottom(i,j,row_s,col_s,enable,thickness);
					if( show_screws==true ) 
						screw_patch_bottom(hole_offset,row_s,col_s,enable,thickness );
				}
	}		
}

module patch_bottom_border(b,row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset,offset = [0,0,0],key_rot = [0,0,0],center_key = [0,0]) {
	hull() {
		translate(offset )
			rotate(key_rot) 
				translate([	-center_key[0]*default_key_horiz_offset,
							-center_key[1]*default_key_vert_offset,0]) {
					translate(base_offset)
						for( i = [row_0:row_n-1] )
							for( j = [col_0:col_n-1] ) 
								if( (borderBottom(b) && isBorderBottom(i,j,row_n-1,col_n-1,enable)) || 
									(borderTop(b)    && isBorderTop   (i,j,row_n-1,col_n-1,enable)) ||
									(borderRight(b)  && isBorderRight (i,j,row_n-1,col_n-1,enable)) ||
									(borderLeft(b)   && isBorderLeft  (i,j,row_n-1,col_n-1,enable)) )
								
									key_patch_bottom(i,j,row_s,col_s,enable,thickness);
					if( show_screws==true ) 		
						screw_patch_bottom(hole_offset,row_s,col_s,enable,thickness );
				}
	}		
}

module keyboard_top_part(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset,enlargement,extend,offset = [0,0,0],key_rot = [0,0,0],center_key = [0,0]) {
	union() {
		translate(offset )
			rotate(key_rot) 
				translate([	-center_key[0]*default_key_horiz_offset,
							-center_key[1]*default_key_vert_offset,0]) {
					for( i = [row_0:row_n-1] )
						for( j = [col_0:col_n-1] )  if( enable[i][j] != 0 && isBorder(i,j,row_n-1,col_n-1,enable) ) {
							patch_top(i,j,row_s,col_s,enable,thickness,enlargement,extend);
					}
				}
	}
}

module keyboard_top_hole(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset,enlargement,extend,offset = [0,0,0],key_rot = [0,0,0],center_key = [0,0]) {
	union() {
		translate(offset )
			rotate(key_rot) 
				translate([	-center_key[0]*default_key_horiz_offset,
							-center_key[1]*default_key_vert_offset,0]) {
					for( i = [row_0:row_n-1] )
						for( j = [col_0:col_n-1] )  if( enable[i][j] != 0 /*&& isBorder(i,j,row_n-1,col_n-1,enable)*/ ) hull() {
							translate(base_offset)
								key_patch_bottom(i,j,row_s,col_s,enable,thickness);
							patch_top(i,j,row_s,col_s,enable,thickness,enlargement,extend);
					}
				}
	}
}

module keyboard_plate_support(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset ) {


}

module keyboard_plate_part(build_screws,row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset,offset = [0,0,0],key_rot = [0,0,0],center_key = [0,0]) {
	union() {
		translate(offset )
			rotate(key_rot) 
				translate([	-center_key[0]*default_key_horiz_offset,
							-center_key[1]*default_key_vert_offset,0]) {
				
					patch_set(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness);
					if( build_screws==true ) 
						keyboard_screw_mounts(hole_offset,row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness );
					//if( show_support==true )
					//	keyboard_plate_support(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,offset);
				}
	}
}

module keyboard_keys(row_0,row_n,col_0,col_n,row_s,col_s,enable,thickness,hole_offset,offset = [0,0,0],key_rot = [0,0,0],center_key = [0,0]) {
	translate(offset )
		rotate(key_rot) 
			translate([	-center_key[0]*default_key_horiz_offset,
						-center_key[1]*default_key_vert_offset,0])
				keyboard_key(	row_0,row_n,col_0,col_n,row_s,col_s,enable,
								[true,true,true,false,true,true],false,1);
}

module keyboard_plate(	show_main, show_thumb, show_func, build_screws,
						m_row_0,m_row_n,m_col_0,m_col_n,m_row_s,m_col_s,m_enable,m_thickness,m_hole_offset,m_offset,m_key_rot,m_center_key,
						t_row_0,t_row_n,t_col_0,t_col_n,t_row_s,t_col_s,t_enable,t_thickness,t_hole_offset,t_offset,t_key_rot,t_center_key,
						f_row_0,f_row_n,f_col_0,f_col_n,f_row_s,f_col_s,f_enable,f_thickness,f_hole_offset,f_offset,f_key_rot,f_center_key) {
	difference() {
		union() {
		/*	hull() {
				if( show_main == true )
					patch_bottom(rows,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset);
				if( show_thumb == true )
					patch_bottom(thumb_rows,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,
									thumb_offset,thumb_key_def_rot,thumb_center_key);
				if( show_func == true )
					patch_bottom(func_rows,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,
									func_offset,func_key_def_rot,func_center_key);
			}*/
			if( show_main == true )
				keyboard_plate_part(build_screws,m_row_0,m_row_n,m_col_0,m_col_n,m_row_s,m_col_s,m_enable,m_thickness,m_hole_offset,m_offset,m_key_rot,m_center_key);
			if( show_thumb == true )
				keyboard_plate_part(build_screws,t_row_0,t_row_n,t_col_0,t_col_n,t_row_s,t_col_s,t_enable,t_thickness,t_hole_offset,t_offset,t_key_rot,t_center_key);
			if( show_func == true )
				keyboard_plate_part(build_screws,f_row_0,f_row_n,f_col_0,f_col_n,f_row_s,f_col_s,f_enable,f_thickness,f_hole_offset,f_offset,f_key_rot,f_center_key);
		}

		union() {
			if( show_main == true )
				keyboard_keys(m_row_0,m_row_n,m_col_0,m_col_n,m_row_s,m_col_s,m_enable,m_thickness,m_hole_offset,m_offset,m_key_rot,m_center_key);
			if( show_thumb == true )
				keyboard_keys(t_row_0,t_row_n,t_col_0,t_col_n,t_row_s,t_col_s,t_enable,t_thickness,t_hole_offset,t_offset,t_key_rot,t_center_key);
			if( show_func == true )
				keyboard_keys(f_row_0,f_row_n,f_col_0,f_col_n,f_row_s,f_col_s,f_enable,f_thickness,f_hole_offset,f_offset,f_key_rot,f_center_key);
			if( build_screws == true ) {
				if( show_main == true )
					keyboard_screws(m_hole_offset,m_row_s,m_col_s,m_enable,m_offset,m_key_rot,m_center_key);
				if( show_thumb == true )
					keyboard_screws(thumb_screw_hole_offset,thumb_row_shift,thumb_col_shift,thumb_key_enable,
											thumb_offset,thumb_key_def_rot,thumb_center_key);
					keyboard_screws(t_row_s,t_col_s,t_enable,t_thickness,t_hole_offset,t_offset,t_key_rot,t_center_key);
				if( show_func == true )
					keyboard_screws(f_row_0,f_row_n,f_col_0,f_col_n,f_row_s,f_col_s,f_enable,f_thickness,f_hole_offset,f_offset,f_key_rot,f_center_key);
			}
		}
	}
}

module keyboard_screws_mount( hole_offset, row_s, col_s, enable,thickness, offset = [0,0,0], key_rot = [0,0,0], center_key = [0,0]) {
	translate(	offset )
		rotate(key_rot) 
			translate([	-center_key[0]*default_key_horiz_offset,
						-center_key[1]*default_key_vert_offset,0])
				union() {
					for( i=[0:len(hole_offset)-1] )
						translate( 	screw_trans( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +//key_trans_noZ( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +
									[default_key_horiz_space/2,default_key_vert_space/2,0])  {
							translate([0,0,-cherry_mx_mount_bottom_thickness+cherry_mx_mount_thickness-0.1]) {
								cylinder( r = m3_diameter, h = thickness, $fn = 30 );
								translate([0,0,thickness-0.1])
									cylinder( r1 = m3_diameter, r2 = m3_diameter/2, h = cherry_mx_mount_thickness, $fn = 30 );
							}
						}
				}
}

module keyboard_screws_mount_hole( hole_offset, row_s, col_s, enable, offset = [0,0,0], key_rot = [0,0,0], center_key = [0,0]) {
	translate(	offset )
		rotate(key_rot) 
			translate([	-center_key[0]*default_key_horiz_offset,
						-center_key[1]*default_key_vert_offset,0])
				union() {
					for( i=[0:len(hole_offset)-1] )
						translate( screw_trans( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +//key_trans_noZ( hole_offset[i][0], hole_offset[i][1], row_s, col_s ) +
									[default_key_horiz_space/2,default_key_vert_space/2,0])  {
							translate([0,0,-cherry_mx_mount_bottom_thickness-0.1])
				#				cylinder( r = m3_diameter/2, h = 30, $fn = 30 ); // hole
						}
				}
}

module keyboard_bottom_thing(thickness) {
	hull() {
		if( with_main == true )
			patch_bottom(rows_0,rows,cols_0,cols,,row_shift,col_shift,key_enable,thickness,screw_hole_offset);
		if( with_thumb == true )
			patch_bottom(thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,thickness,thumb_screw_hole_offset,
							thumb_offset,thumb_key_def_rot,thumb_center_key);
		if( with_func == true )
			patch_bottom(func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,thickness,func_screw_hole_offset,
							func_offset,func_key_def_rot,func_center_key);
	}
}

module keyboard_bottom_main(thickness) {
	hull() {
		if( with_main == true )
			patch_bottom(rows,cols,row_shift,col_shift,key_enable,thickness,screw_hole_offset);
	}
}

module keyboard_bottom_thumb(thickness) {
	hull() {
		if( with_thumb == true )
			patch_bottom(thumb_rows,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,thickness,thumb_screw_hole_offset,
							thumb_offset,thumb_key_def_rot,thumb_center_key);
	}
}

module keyboard_bottom_func(thickness) {
	hull() {
		if( with_func == true )
			patch_bottom(func_rows,func_cols,func_row_shift,func_col_shift,func_key_enable,thickness,func_screw_hole_offset,
							func_offset(),func_key_def_rot,func_center_key);
	}
}

module keyboard_bottom() {
	difference() {
		union() {
			minkowski() {
				keyboard_bottom_thing(cherry_mx_mount_thickness/2);
				translate([0,0,-cherry_mx_mount_thickness/4]) cylinder( r = m3_diameter*1.5, h = cherry_mx_mount_thickness/2 );
			}
			
			translate([0,0,cherry_mx_mount_thickness/2]) difference() {
				minkowski() {
					keyboard_bottom_thing(cherry_mx_mount_thickness/2);
					translate([0,0,-cherry_mx_mount_thickness/4]) cylinder( r = m3_diameter, h = cherry_mx_mount_thickness/2 );
				}
				translate([0,0,cherry_mx_mount_thickness/4])
					keyboard_bottom_thing(cherry_mx_mount_thickness+0.2);
			}
			
			if( show_screws==true ) union() {
				if( with_main == true )
					keyboard_screws_mount(screw_hole_offset,row_shift,col_shift,key_enable,standoff_thickness);
				if( with_thumb == true )
					keyboard_screws_mount(thumb_screw_hole_offset,thumb_row_shift,thumb_col_shift,thumb_key_enable,standoff_thickness,
											thumb_offset,thumb_key_def_rot,thumb_center_key);
				if( with_func == true )
					keyboard_screws_mount(func_screw_hole_offset,func_row_shift,func_col_shift,func_key_enable,standoff_thickness,
											func_offset,func_key_def_rot,func_center_key);
			}
		}
		if( show_screws==true ) union() {
			if( with_main == true )
				keyboard_screws_mount_hole(screw_hole_offset,row_shift,col_shift,key_enable);
			if( with_thumb == true )
				keyboard_screws_mount_hole(thumb_screw_hole_offset,thumb_row_shift,thumb_col_shift,thumb_key_enable,
										thumb_offset,thumb_key_def_rot,thumb_center_key);
			if( with_func == true )
				keyboard_screws_mount_hole(func_screw_hole_offset,func_row_shift,func_col_shift,func_key_enable,
										func_offset,func_key_def_rot,func_center_key);
		}
	}
}

module keyboard_top_band(thickness,growAdd, growRemove) {
	difference() {
		minkowski() {
			keyboard_bottom_thing(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growAdd, h = thickness/2 );
		}
		translate([0,0,-0.1]) minkowski() {
			keyboard_bottom_thing(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growRemove, h = thickness/2+0.2 );
		}
	}
}

module keyboard_top_band_main(thickness,growAdd, growRemove) {
	if( with_main == true ) difference() {
		minkowski() {
			keyboard_bottom_main(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growAdd, h = thickness/2 );
		}
		translate([0,0,-0.1]) minkowski() {
			keyboard_bottom_main(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growRemove, h = thickness/2+0.2 );
		}
	}
}

module keyboard_top_band_thumb(thickness,growAdd, growRemove) {
	if( with_thumb == true ) difference() {
		minkowski() {
			keyboard_bottom_thumb(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growAdd, h = thickness/2 );
		}
		translate([0,0,-0.1]) minkowski() {
			keyboard_bottom_thumb(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growRemove, h = thickness/2+0.2 );
		}
	}
}

module keyboard_top_band_func(thickness,growAdd, growRemove) {
	if( with_func == true ) difference() {
		minkowski() {
			keyboard_bottom_func(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growAdd, h = thickness/2 );
		}
		translate([0,0,-0.1]) minkowski() {
			keyboard_bottom_func(thickness/2);
			translate([0,0,-thickness/4]) cylinder( r = growRemove, h = thickness/2+0.2 );
		}
	}
}

module keyboard_top() {
	step = 18 ;
	stepMain = 10 ;
	stepThumb = 7 ;
	stepFunc = 10 ;
	enlargementAdd = 1.5 ;
	extendAdd = 0 ;
	enlargementRemove = 1.0 ;
	extendRemove = 20 ;
	topOffset = [0,0,20];
	
	topAdd = m3_diameter*1.5 ;
	topThickness = 2 ;
	
	
	translate([0,0,cherry_mx_mount_thickness/2]) 
		keyboard_top_band(cherry_mx_mount_thickness,topAdd,topAdd - topThickness);
	//	for( i = [0:step:cherry_mx_mount_bottom_thickness+standoff_thickness+cherry_mx_mount_thickness] ) {
	translate([0,0,cherry_mx_mount_thickness+step/2])
		keyboard_top_band(step,topAdd,topAdd - topThickness);
//}
	difference() {
		union() {
			translate([0,0,cherry_mx_mount_thickness+step/2])
				keyboard_top_band(step,topAdd,topAdd - topThickness);
			translate([0,0,cherry_mx_mount_thickness+step+stepMain/2])
				keyboard_top_band_main(stepMain,0.1,- topThickness);
			translate([0,0,cherry_mx_mount_thickness+step+stepThumb/2])
				keyboard_top_band_thumb(stepThumb,0.1,- topThickness);
			translate([0,0,cherry_mx_mount_thickness+step+stepFunc/2])
				keyboard_top_band_func(stepFunc,0.1,- topThickness);
				
			hull() {
				translate([0,0,cherry_mx_mount_thickness+step/2])
					keyboard_top_band(step,topAdd,topAdd - topThickness);
				translate([0,0,cherry_mx_mount_thickness+step+stepMain/2])
					keyboard_top_band_main(stepMain,0.1,- topThickness);
			}
			
			hull() {
				translate([0,0,cherry_mx_mount_thickness+step/2])
					keyboard_top_band(step,topAdd,topAdd - topThickness);
				translate([0,0,cherry_mx_mount_thickness+step+stepThumb/2])
					keyboard_top_band_thumb(stepThumb,0.1,- topThickness);
			}
			
			hull() {
				translate([0,0,cherry_mx_mount_thickness+step/2])
					keyboard_top_band(step,topAdd,topAdd - topThickness);
				translate([0,0,cherry_mx_mount_thickness+step+stepFunc/2])
					keyboard_top_band_func(stepFunc,0.1,- topThickness);
			}
				/*translate([0,0,standoff_thickness+cherry_mx_mount_thickness]){
					if( with_main == true )
						keyboard_top_part(rows,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,enlargementAdd,extendAdd);
					if( with_thumb == true )
						keyboard_top_part(thumb_rows,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,enlargementAdd,extendAdd,
											thumb_offset,thumb_key_def_rot,thumb_center_key);
					if( with_func == true )
						keyboard_top_part(func_rows,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,enlargementAdd,extendAdd,
											func_offset(),func_key_def_rot,func_center_key);
				}*/
			
		}
		union() {
				hull() 
					translate([0,0,cherry_mx_mount_thickness+step/2-0.1])
						keyboard_top_band(step,m3_diameter*0.6,m3_diameter*0.3);
		//this needs to be each section outline (main,thumb,func) hulled with the top part for that section
				if( with_main == true ) union() {
					translate([0,0,cherry_mx_mount_thickness+step/2-0.1])
						keyboard_top_band_main(step,m3_diameter*0.6,m3_diameter*0.3);
					translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
						keyboard_top_hole(rows,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,enlargementRemove,extendRemove);
				}
				if( with_thumb == true ) union() {
					translate([0,0,cherry_mx_mount_thickness+step/2-0.1])
						keyboard_top_band_thumb(step,m3_diameter*0.6,m3_diameter*0.3);
					translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
						keyboard_top_hole(thumb_rows,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,enlargementRemove,extendRemove,
											thumb_offset,thumb_key_def_rot,thumb_center_key);
				}
				if( with_func == true ) union() {
					translate([0,0,cherry_mx_mount_thickness+step/2-0.1])
						keyboard_top_band_func(step,m3_diameter*0.6,m3_diameter*0.3);
					translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
						keyboard_top_hole(func_rows,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,enlargementRemove,extendRemove,
											func_offset,func_key_def_rot,func_center_key);
				}
			
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
		if( show_base == true ) {
			keyboard_bottom();
		}
		if( show_plate == true ) {
			if( split_parts == true ) {
				difference() {
					translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws,
									rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,[0,0,0],[0,0,0],[0,0],
									thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,thumb_offset,thumb_key_def_rot,thumb_center_key,
									func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,func_offset,func_key_def_rot,func_center_key);
					translate([ 5.2*default_key_horiz_offset,
							-3*default_key_vert_offset,
							-20] ) cube(220);
				}
			} else {
				translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws,
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
					keyboard_plate( with_main,with_thumb,with_func, show_screws,
									rows_0,rows,cols_0,cols,row_shift,col_shift,key_enable,cherry_mx_mount_thickness,screw_hole_offset,[0,0,0],[0,0,0],[0,0],
									thumb_rows_0,thumb_rows,thumb_cols_0,thumb_cols,thumb_row_shift,thumb_col_shift,thumb_key_enable,cherry_mx_mount_thickness,thumb_screw_hole_offset,thumb_offset,thumb_key_def_rot,thumb_center_key,
									func_rows_0,func_rows,func_cols_0,func_cols,func_row_shift,func_col_shift,func_key_enable,cherry_mx_mount_thickness,func_screw_hole_offset,func_offset,func_key_def_rot,func_center_key);
						translate([ 5.1*default_key_horiz_offset,
								-3*default_key_vert_offset,
								-20] ) cube(220);
					}
				} else {
					translate([0,0,standoff_thickness+cherry_mx_mount_thickness])
					keyboard_plate( with_main,with_thumb,with_func, show_screws,
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
}

function maximum(a, i = 0) = (i < len(a) - 1) ? max(a[i], maximum(a, i +1)) : a[i];
function maximum0(a, i = 0) = (i < len(a) - 1) ? max(a[i][0], maximum0(a, i +1)) : a[i][0];
function maximum1(a, i = 0) = (i < len(a) - 1) ? max(a[i][1], maximum0(a, i +1)) : a[i][1];
function minimum(a, i = 0) = (i < len(a) - 1) ? min(a[i], maximum(a, i +1)) : a[i];
function minimum0(a, i = 0) = (i < len(a) - 1) ? min(a[i][0], minimum0(a, i +1)) : a[i][0];
function minimum1(a, i = 0) = (i < len(a) - 1) ? min(a[i][1], minimum0(a, i +1)) : a[i][1];

function find( val,tab,def,i=0) =  i>=len(tab)?def:(val==tab[i][0]?tab[i][1]:find(val,tab,def,i+1));

function key_part(i,j,q,enable,table,def) = find(q,find( enable[i][j],table,[]),def);

function get_h(i,j,row_s,col_s) = (-cherry_mx_mount_bottom_thickness+-row_s[i][shift_z]-col_s[j][shift_z]);

function key_row_translationY( row_s, i ) = (i<0)?0:(row_s[i][shift_y]+((i==0)?0:(default_key_vert_offset +key_row_translationY( row_s, i-1 ) )));
function key_col_translationX( col_s, j ) = (j<0)?0:(col_s[j][shift_x]+((j==0)?0:(default_key_horiz_offset+key_col_translationX( col_s, j-1 ) )));
function key_row_translation( row_s,i ) = [ row_s[i][shift_x],key_row_translationY( row_s, i ),row_s[i][shift_z] ];
function key_col_translation( col_s,j ) = [key_col_translationX( col_s, j ),col_s[j][shift_y],col_s[j][shift_z] ];

function key_translation( i, j, row_s, col_s ) =	key_row_translation( row_s,i ) + 
													key_col_translation( col_s,j );

function key_row_trans_noZ( row_s,i ) = [ row_s[i][shift_x],key_row_translationY( row_s, i ),0 ];
function key_col_trans_noZ( col_s,j ) = [key_col_translationX( col_s, j ),col_s[j][shift_y],0 ];

function key_trans_noZ( i, j, row_s, col_s ) =	key_row_trans_noZ( row_s,i ) +
												key_col_trans_noZ( col_s,j );
												
												
function screw_trans( i, j, row_s, col_s ) =	((i==floor(i))?key_row_trans_noZ( row_s,i ):(part_between(key_row_trans_noZ( row_s,floor(i) ),key_row_trans_noZ( row_s,ceil(i) ),i-floor(i)))) +
												((j==floor(j))?key_col_trans_noZ( col_s,j ):(part_between(key_col_trans_noZ( col_s,floor(j) ),key_col_trans_noZ( col_s,ceil(j) ),j-floor(j))));
												
function isBorder( i,j, r,c, enable ) =  (i==0||i==r||j==0||j==c)?true:
											(i==1 && enable[0][j] == 0)?true:
											(i==r-1 && enable[r][j] == 0)?true:
											(j==1 && enable[i][0] == 0)?true:
											(j==c-1 && enable[i][c] == 0)?true:false;
function isBorderTop( i,j, r,c, enable ) =  (i==r)?true:
											(i==r-1 && enable[r][j] == 0)?true:false;
function isBorderBottom( i,j, r,c, enable ) =  (i==0)?true:
											(i==1 && enable[0][j] == 0)?true:false;

function isBorderRight( i,j, r,c, enable ) =  (j==c)?true:
											(j==c-1 && enable[i][c] == 0)?true:false;
function isBorderLeft( i,j, r,c, enable ) =  (j==0)?true:
											(j==1 && enable[i][0] == 0)?true:false;

function borderTop( b ) = (b <= 0)?false:(b%10==1)?true:borderTop(int(b/10));
function borderBottom( b ) = (b <= 0)?false:(b%10==2)?true:borderBottom(int(b/10));
function borderRight( b ) = (b <= 0)?false:(b%10==3)?true:borderRight(int(b/10));
function borderLeft( b ) = (b <= 0)?false:(b%10==4)?true:borderLeft(int(b/10));

function part_between(x,y,d) = x + (y-x)*d;