
//color("blue") rotate([0,0,-60]) translate([-25,-21,-50])  import("Kossel_Rav_Alt_bottom_frame_20mm_V3(centered).stl");
//#

module bevel_square( dim, r= 2 ){
   intersection() {
      cube(dim,center=true);
      minkowski(){
         translate([0,0,r]) cube(dim-[2*r,2*r,0],center=true);
         sphere(r=r,center=true,$fn =32);
      }
   }
}

rotate([180,0,0])difference(){
	union() {
	//	scale([1,1.3,1]) rotate([180,0,0]) cylinder(r=19.5, h = 5 );
		translate([0,0,-5.5]) bevel_square([28,28,9],r=2);
     // translate([0,0,-10]) bevel_square([28,28,3],r=2);
		/*hull() {
			translate([0,0, 0]) cube([25,25,0.1],center = true);
			translate([0,0, -2.95]) cube([28,28,0.1],center = true);

		}*/
		
	/*	hull() { 
			for( i = [-1,1] ) translate([-30,0,0]) rotate([0,0,i*30])
			{
				translate([28.865,0,0]) rotate([0,0,-i*30])
					translate([0,0,-2.5]) cube([15,10,5],center = true);
			}
			translate([0,0,-2.5]) cube([15,15,5],center = true);
		}*/

		for( i = [-1,1] ) hull() {
	//		scale([1,1.3,1]) 
       //  rotate([180,0,0]) 
         translate([0,0,-2.5])
         bevel_square([28,28,5],r=2);
         
			translate([-30,0,0]) rotate([0,0,i*30])
			{
			//	translate([28.865,0,0]) rotate([0,0,-i*30])
			//		translate([0,0,-2.5]) cube([15,10,5],center = true);
				translate([50-17/2,0,0]) 
					translate([0,0,-2.5]) bevel_square([5,20,5],r=2);
			//	translate([82,0,0]) 
			//		translate([0,0,-2.5]) cube([20,20,5],center = true);
			}
		}
		for( i = [-1,1] ) hull() {
			translate([-30,0,0]) rotate([0,0,i*30])
			{
				translate([50,0,0]) 
					translate([0,0,-2.5]) bevel_square([20,20,5],r=2);
				translate([82,0,0]) 
					translate([0,0,-2.5]) bevel_square([20,20,5],r=2);
			}
		}
			
		for( i = [-1,1] ) {
			translate([-30,0,0]) rotate([0,0,i*30])
			{
				translate([82,0,0]) 
					translate([0,0,-5.5]) bevel_square([20,20,9],r=2);
			}
		}
	}
	translate([0,0,-8]) hull() {
		translate([0,0, -4]) cube([20,20,0.1],center = true);
		translate([0,0, 0]) cube([18,18,0.1],center = true);

	}
	translate([0,0,-12.1])cylinder( r=3, h = 20,$fn=20 );
#	translate([0,0,-18])cylinder( r=6, h = 15.3,$fn=20 );
	
	for( i = [-1,1] ) {
		translate([-30,0,0]) rotate([0,0,i*30])
			translate([82,0,0]) {
				translate([0,0,-12.1])cylinder( r=3, h = 20,$fn=20 );
				translate([0,0,-18])cylinder( r=6, h = 15.3,$fn=20 );
            translate([0,0,-8]) hull() {
               translate([0,0, -4]) cube([14,14,0.1],center = true);
               translate([0,0, 0]) cube([12,12,0.1],center = true);

            }
			}
	}
	
}


