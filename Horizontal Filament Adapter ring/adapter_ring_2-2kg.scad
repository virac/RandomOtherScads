thickness = 2.5 ;
spool_diameter = 51 ;
spool_second_diameter = 84 ;
radial_offset = 28 ;
radial_diameter = 20 ;
/*difference() {
	union() {
		cylinder( r1 = spool_diameter/2, r2 = spool_diameter/2+10, h = thickness+6.1, $fn = 150 );

		translate([0,0,thickness]) 
			cylinder(r = spool_diameter/2, h = 40, $fn = 100);
	}
	translate([0,0,-0.1]) union() {
		cylinder( r = radial_diameter/2, h = thickness+0.3 );
		for( i = [0:2] ) {
			rotate([0,0,i*120]) translate( [radial_offset,0,0] )
				cylinder( r = radial_diameter/2, h = thickness+0.3 );
		}
		translate([0,0,thickness]) cylinder(r = (spool_diameter-thickness)/2, h = 40+0.2, $fn = 100);
	}
}
	translate([spool_diameter/2+spool_second_diameter/2+20,0,0])*/
	difference() {
		union() {
			cylinder( r = spool_second_diameter/2+10, h = thickness, $fn = 150 );
			translate([0,0,thickness]) 
				cylinder(r = spool_second_diameter/2, h = 10, $fn = 100);
		}
	
		translate([0,0,0]) 
			cylinder(r = spool_diameter/2+0.5, h = 40, $fn = 100);
		translate([0,0,thickness]) 
			cylinder(r = (spool_second_diameter-thickness)/2, h = 10.2, $fn = 100);
		translate([spool_second_diameter/2,0,thickness]) 
			cylinder(r = (spool_second_diameter-thickness)/4, h = 10.2, $fn = 100);
	}