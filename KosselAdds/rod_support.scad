
m3_diameter = 3.2 ;
m3_head_diameter = 5.7 ;
m3_head_thickness = 3.0 ;
m3_nut_diameter = 6.6 ;
m3_nut_thickness = 2.5 ;
m3_tap_diameter = 2.5 ;

m5_diameter = 5.2;
m5_cap_length = 5;
m5_nut_diameter = 9.4;
m5_washer_diameter = 10;
m5_nut_thickness = 2.7;
m5_tap_diameter = 4.3;


rod_dia = 8.4 ;
thickness = 2 ;
length = 20 ;

module carriage(useEndstop) {
	difference() {
		union() {
			for( i=[-1,1] ){
				translate([i*30, 0,0]) {
					cylinder( r = rod_dia/2+thickness, h = length );
					translate([i*(rod_dia/2+m3_nut_diameter/2)/2, (rod_dia/2+thickness)-(rod_dia*0.4)/2,length/2]) cube([rod_dia/2+m3_nut_diameter/2,rod_dia*0.4,length],center=true);
					translate([i*(rod_dia/2+m3_nut_diameter/2)/2,-(rod_dia/2+thickness)+(rod_dia*0.4)/2,length/2]) cube([rod_dia/2+m3_nut_diameter/2,rod_dia*0.4,length],center=true);
					
					translate([i*(rod_dia/2.4+m3_nut_diameter/2.4),0,length/2]) rotate([90,0,0]) cylinder( r = m3_nut_diameter/1.5, h=  rod_dia+thickness*2, center = true, $fn=30);
		
		
					hull(){
						intersection() {
							translate([i*(rod_dia/2.4+m3_nut_diameter/2.4),0,length/2]) rotate([90,0,0]) translate([0,0,(rod_dia+thickness*2)/2])
								cylinder( r = m3_nut_diameter, h=  m3_head_thickness, center = true, $fn=30);
				
							translate([i*(rod_dia/2+m3_nut_diameter/2)/2,-(rod_dia/2+thickness)+(rod_dia*0.4)/2,length/2]) cube([rod_dia/2+m3_nut_diameter/2,rod_dia*0.4,length],center=true);
						}
						translate([i*(rod_dia/2.4+m3_nut_diameter/2.4),0,length/2]) rotate([90,0,0]) translate([0,0,(rod_dia+thickness*2)/2])
							cylinder( r = m3_nut_diameter/1.5, h=  m3_head_thickness, center = true, $fn=30);
					}
					hull(){
						intersection() {
							translate([i*(rod_dia/2.4+m3_nut_diameter/2.4),0,length/2]) rotate([90,0,0]) translate([0,0,-(rod_dia+thickness*2)/2])
								cylinder( r = m3_nut_diameter, h=  m3_head_thickness, center = true, $fn=30);
								
							translate([i*(rod_dia/2+m3_nut_diameter/2)/2, (rod_dia/2+thickness)-(rod_dia*0.4)/2,length/2]) cube([rod_dia/2+m3_nut_diameter/2,rod_dia*0.4,length],center=true);
						}
						translate([i*(rod_dia/2.4+m3_nut_diameter/2.4),0,length/2]) rotate([90,0,0]) translate([0,0,-(rod_dia+thickness*2)/2])
							cylinder( r = m3_nut_diameter/1.5, h=  m3_head_thickness, center = true, $fn=30);
					}
				}
			}
			translate([0,-11.6,length/2]) {
				cube([length,5,length],center=true);
				for( i=[-1,1] ) hull() {
					translate([i*(length+0.1)/2,0,0]) cube([0.1,5,length], center=true);
					
					translate([i*(30-rod_dia/2-thickness/2),11.6,-length/2]) {
						cylinder( r = thickness*1.25, h = length );
					}
				}
			}
			if( useEndstop) {
				translate([11,9,length/2]) {
					cube([18,5,length],center=true);
				}
				hull() {
					translate([20,9,length/2]) {
						cube([thickness,5,length],center=true);
					}
					translate([-(-30+rod_dia/2+thickness/2),0,0]) {
						cylinder( r = thickness*1.25, h = length );
					}
				}
			}
		}
		union() {
			for( i=[-1,1] ){
				translate([i*30, 0, -0.1]) {
					cylinder( r = rod_dia/2, h = length*2,$fn=30 );
					translate([i*rod_dia,0,length/2-0.1]) cube([rod_dia*2,rod_dia*.7,length*2],center=true);
					translate([i*(rod_dia/2.4+m3_nut_diameter/2.4),0,length/2+0.1]) rotate([90,0,0]) {
						rotate([0,180,0]) translate([0,0,(rod_dia+m3_head_thickness*1.5)/2]) cylinder( r = m3_head_diameter/2, h=  m3_head_thickness, center = true, $fn = 30);
						rotate([0,0,90]) translate([0,0,(rod_dia+m3_nut_thickness*2.5)/2]) cylinder( r = m3_nut_diameter/2, h=  m3_nut_thickness*2, center = true, $fn = 6);
						cylinder( r = m3_diameter/2, h=  (rod_dia+thickness*2)*2, center = true, $fn = 30);
					}
				}
			}
			translate([0,-11.6,length/2]) rotate([90,0,0]){
				cylinder( r = m5_diameter/2, h = 10, center =true,$fn=30);
	#			translate([0,0,2.5-4]) rotate([180,0,0]) cylinder( r = m5_washer_diameter/2, h = 25,$fn=30);
			}
			
			if( true ) { 
				if( useEndstop) translate([14.5,11.1,length/2]) {
					cube([17,1,length+0.2],center=true);
					translate([0.5,-0.45,length/2-3.6/2]) minkowski() {
						cube([17,1,3.6],center=true);
						rotate([0,90,0]) cylinder( r = 0.5, h = 1, $fn = 10, center=true );
					}
					rotate([90,0,0]) translate([-1,0,-1]) cylinder(r=m3_diameter/2, h=10,center=false,$fn=30);
					rotate([90,0,0]) translate([-1,0,4]) rotate([0,0,90]) cylinder(r=m3_nut_diameter/2, h=m3_nut_thickness,center=true,$fn=6);
				}
			}
			else {
				if( useEndstop) translate([14.5,11.1,length/2]) {
					cube([15,1,length+0.2],center=true);
					translate([0,-0.95,length/2-1]) cube([15,1,2.6],center=true);
					rotate([90,0,0]) translate([0,0,-1]) cylinder(r=m3_diameter/2, h=10,center=false,$fn=30);
					rotate([90,0,0]) translate([0,0,4]) cylinder(r=m3_nut_diameter/2, h=m3_nut_thickness,center=true,$fn=6);
				}
			}
		}
	}
}

//color("blue") rotate([0,0,180]) translate([-40,-20,-20]) import("carriage-slim_holder_double.stl");
//color("blue")rotate([0,0,60]) translate([-42,-37,-50])  import("Kossel_Alt_-_20mm_extrusion_-_8mm_smooth_rods/Kossel_Rav_Alt_bottom_frame_20mm_V3(centered).stl");
//
/*
translate([-45,0,0]){
	translate([0,-15,0])
		carriage(false);
	translate([0,0,0])
		carriage(false);
	translate([0,15,0])
		carriage(false);
}*/
translate([40,0,0]){
	//translate([0,-27,0])
	//	carriage(true);
	translate([0,0,0])
		carriage(true);
//	translate([0,27,0])
	//	carriage(true);
}
