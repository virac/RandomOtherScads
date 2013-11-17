include <bolts.scad>

show_phone=false;

stand_thickness = 20;
stand_extra = 10;
stand_angle = 70;
base_height = 15;

charger_top_diameter = 70;
charger_top_thickness = 8.2;
charger_bottom_diameter = 67;
charger_bottom_thickness = 3.5;
charger_foot_thickness = 1.2;
charger_foot_width = 5.1;
charger_foot_length = 10.1;

charger_thickness = charger_top_thickness+charger_bottom_thickness+charger_foot_thickness;

cable_clearance_width = 12;
cable_clearance_height = 7;

phone_length = 139;
phone_width = 74;
phone_thickness = 12;

stand_width = phone_width + 2* stand_extra;

difference() {
	union() {
		translate([0,0,base_height/2])
			cube([cos(stand_angle)*phone_length+stand_thickness, stand_width,base_height+stand_extra], center=true);
		translate([0,0,(sin(stand_angle)*phone_length+base_height)/2])
			rotate([0,-stand_angle,0]) translate([0,0,-phone_thickness/2-charger_thickness])
				cube([phone_length,phone_width,phone_thickness/2+charger_thickness],center = true);
	}
	union() {
		translate([0,0,(sin(stand_angle)*phone_length+base_height)/2])
			rotate([0,-stand_angle,0]) {
				translate([0,0,phone_thickness/4-charger_thickness/2])
					cube([phone_length,phone_width,phone_thickness],center = true);
				translate([0,0,-(charger_thickness+phone_thickness/2)])
					scale([1.01,1.01,1.01]) charger();
			}
	}
}

if( show_phone==true )
translate([0,0,(sin(stand_angle)*phone_length+base_height)/2])
	rotate([0,-stand_angle,0]) 
		phone();
//charger();




module phone() {
	color("RoyalBlue") cube([phone_length,phone_width,phone_thickness],center = true);
}
module charger() {
	translate([0,0,charger_foot_thickness])
		cylinder( r=charger_bottom_diameter/2,h=charger_bottom_thickness+0.1);
	translate([0,0,charger_bottom_thickness+charger_foot_thickness])
		cylinder( r=charger_top_diameter/2,h=charger_top_thickness);
	rotate([0,0,45]) {
		for( i = [0:3] ) {
			hull() rotate([0,0,i*90]) {
				translate([28.5,charger_foot_length/2-charger_foot_width/2,0]) 
					cylinder( r = charger_foot_width/2, h = charger_foot_thickness+0.1);
				translate([28.5,-(charger_foot_length/2-charger_foot_width/2),0])
					cylinder( r = charger_foot_width/2, h = charger_foot_thickness+0.1);
			}
		}
	}
}
