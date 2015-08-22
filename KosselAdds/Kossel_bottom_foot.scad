
color("blue")rotate([0,0,-30]) translate([38.5,35,0])  import("Kossel_Rav_Alt_top_frame_optional_support (repaired).stl");
//#
rotate([180,0,0])difference(){
	union() {
		scale([1,1.3,1]) rotate([180,0,0]) cylinder(r=19.5, h = 5 );
		translate([0,0,-5.5]) cube([25,25,11],center = true);
		translate([0,0,-8]) hull() {
			translate([0,0, 0]) cube([25,25,0.1],center = true);
			translate([0,0, -2.95]) cube([28,28,0.1],center = true);

		}
		
		hull() { 
			for( i = [-1,1] ) translate([-30,0,0]) rotate([0,0,i*30])
			{
				translate([28.865,0,0]) rotate([0,0,-i*30])
					translate([0,0,-2.5]) cube([15,10,5],center = true);
			}
			translate([0,0,-2.5]) cube([15,15,5],center = true);
		}

		for( i = [-1,1] ) hull() {
			scale([1,1.3,1]) rotate([180,0,0]) cylinder(r=19.5, h = 5 );
			translate([-30,0,0]) rotate([0,0,i*30])
			{
			//	translate([28.865,0,0]) rotate([0,0,-i*30])
			//		translate([0,0,-2.5]) cube([15,10,5],center = true);
				translate([50,0,0]) 
					translate([0,0,-2.5]) cube([20,20,5],center = true);
			//	translate([82,0,0]) 
			//		translate([0,0,-2.5]) cube([20,20,5],center = true);
			}
		}
		for( i = [-1,1] ) hull() {
			translate([-30,0,0]) rotate([0,0,i*30])
			{
				translate([50,0,0]) 
					translate([0,0,-2.5]) cube([20,20,5],center = true);
				translate([82,0,0]) 
					translate([0,0,-2.5]) cube([20,20,5],center = true);
			}
		}
			
		for( i = [-1,1] ) {
			translate([-30,0,0]) rotate([0,0,i*30])
			{
				translate([82,0,0]) 
					translate([0,0,-4]) cube([20,20,8],center = true);
			}
		}
	}
	translate([0,0,-8]) hull() {
		translate([0,0, -3]) cube([20,20,0.1],center = true);
		translate([0,0, 0]) cube([22,22,0.1],center = true);

	}
	translate([0,0,-12.1])cylinder( r=3, h = 20,$fn=20 );
	translate([0,0,-8])cylinder( r=6, h = 5.3,$fn=20 );
	
	for( i = [-1,1] ) {
		translate([-30,0,0]) rotate([0,0,i*30])
			translate([82,0,0]) {
				translate([0,0,-12.1])cylinder( r=3, h = 20,$fn=20 );
				translate([0,0,-8.1])cylinder( r=6, h = 5.3,$fn=20 );
			}
	}
	
}


