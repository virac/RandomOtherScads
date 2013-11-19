

center_pole_diameter = 4;
center_pole_height = 3.2;

fixing_pin_diameter = 1.7;
fixing_pin_height = 3.3;

key_pin_diameter = 1.5;
key_pin_height = 3.3;

led_pin_diameter = 1;
led_pin_height = 3.3;

cherry_mx_outer_width = 15.6;
cherry_mx_outer_thickness = 11;
cherry_mx_mount_pin_thickness = 5;
cherry_mx_top_thickness = cherry_mx_outer_thickness-cherry_mx_mount_pin_thickness;

cherry_mx_keycap_buffer = 0.6;

cherry_mx_mount_width = 14;
cherry_mx_mount_thickness = 1.5;

grid_space = 1.27;
key_pin1_pos = [-3,2,0];
key_pin2_pos = [2,4,0];
fixing_pin1_pos = [-4,0,0];
fixing_pin2_pos = [4,0,0];
led_pin1_pos = [-1,-4,0];
led_pin2_pos = [1,-4,0];

//cherry_keyswitch(fixing_pins = true, led_pins = false, show_part = [true,true,true,true,true,true]);

module cherry_keyswitch( fixing_pins = true, led_pins = false, show_part = [true,true,true,true,false,false]) {
	translate([0,0,cherry_mx_mount_thickness]) {
		if( show_part[0] == true ) {
			translate([0,0,cherry_mx_top_thickness/2])
				cube([cherry_mx_outer_width,cherry_mx_outer_width,	
						cherry_mx_top_thickness],center = true);
		}

		if( show_part[5] == true ) { // cap extension
			translate([0,0,cherry_mx_top_thickness])
				cube([cherry_mx_outer_width,cherry_mx_outer_width,	
						2],center = true);

		}

		if( show_part[4] == true ) { //space for the grip
			translate([0,0,cherry_mx_top_thickness/2+0.5])
				cube([4,
						cherry_mx_outer_width+2*cherry_mx_keycap_buffer,	
						cherry_mx_top_thickness+1],center = true);
		}
		if( show_part[1] == true ) {
			cube([min(cherry_mx_outer_width,cherry_mx_mount_width),
					min(cherry_mx_outer_width,cherry_mx_mount_width),	
					0.2],center = true);

			translate([0,0,-(cherry_mx_mount_pin_thickness)/2])
				cube([cherry_mx_mount_width,cherry_mx_mount_width,	
						cherry_mx_mount_pin_thickness],center = true);
		}
	
		if( show_part[2] == true ) {
			translate([0,0,-(cherry_mx_mount_thickness+(3.5+max(center_pole_height,fixing_pin_height))/2)])
				cube([4,
						half_between(cherry_mx_outer_width,cherry_mx_mount_width),	
						3.5+max(center_pole_height,fixing_pin_height)],center = true);
		}

		if( show_part[3] == true ) translate([0,0,-cherry_mx_mount_pin_thickness]) {
			color("Black") rotate([180,0,0]) 
				cylinder(r = center_pole_diameter/2, h = center_pole_height);
	
			color("Blue"){
				translate(grid_space*key_pin1_pos) rotate([180,0,0]) 
					cylinder(r = key_pin_diameter/2, h = key_pin_height);
				translate(grid_space*key_pin2_pos) rotate([180,0,0]) 
					cylinder(r = key_pin_diameter/2, h = key_pin_height);
			}
	
			if( fixing_pins == true ) color("Black") {
				translate(grid_space*fixing_pin1_pos) rotate([180,0,0]) 
					cylinder(r = fixing_pin_diameter/2, h = fixing_pin_height);
				translate(grid_space*fixing_pin2_pos) rotate([180,0,0]) 
					cylinder(r = fixing_pin_diameter/2, h = fixing_pin_height);
			}

			if( led_pins == true ) color("Blue") {
				translate(grid_space*led_pin1_pos) rotate([180,0,0]) 
					cylinder(r = led_pin_diameter/2, h = led_pin_height);
				translate(grid_space*led_pin2_pos) rotate([180,0,0]) 
					cylinder(r = led_pin_diameter/2, h = led_pin_height);
			}
		} else {
			translate([0,0,-(cherry_mx_mount_pin_thickness)])
				cube([cherry_mx_mount_width,
						cherry_mx_mount_width,	
						0.2],center = true);

			translate([0,0,-(cherry_mx_mount_pin_thickness)-max(center_pole_height,fixing_pin_height)])
				cube([cherry_mx_mount_width,cherry_mx_mount_width,	
						max(center_pole_height,fixing_pin_height)*2],center = true);
		}
	}
}

function half_between(x,y) = x + (y-x)/2;
