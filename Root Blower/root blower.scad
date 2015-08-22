use <MCAD/trochoids.scad>

module epitrochoidLinear(R, r, d, n, p, thickness, twist) {
	dth = 360/n;
	linear_extrude(height = thickness, convexity = 10, twist = twist) {
	union() {
	for ( i = [0:p-1] ) {
			polygon(points = [[0, 0], 
			[(R+r)*cos(dth*i) - d*cos((R+r)/r*dth*i), (R+r)*sin(dth*i) - d*sin((R+r)/r*dth*i)], 
			[(R+r)*cos(dth*(i+1)) - d*cos((R+r)/r*dth*(i+1)), (R+r)*sin(dth*(i+1)) - d*sin((R+r)/r*dth*(i+1))]], 
			paths = [[0, 1, 2]], convexity = 10); 
	}
	}
	}
}
//===========================================


//===========================================
// Hypotrochoid Wedge, Linear Extrude
//
module hypotrochoidLinear(R, r, d, n, p, thickness, twist) {
	dth = 360/n;
	linear_extrude(height = thickness, convexity = 10, twist = twist) {
	union() {
	for ( i = [0:p-1] ) {
			polygon(points = [[0, 0], 
			[(R-r)*cos(dth*i) + d*cos((R-r)/r*dth*i), (R-r)*sin(dth*i) - d*sin((R-r)/r*dth*i)], 
			[(R-r)*cos(dth*(i+1)) + d*cos((R-r)/r*dth*(i+1)), (R-r)*sin(dth*(i+1)) - d*sin((R-r)/r*dth*(i+1))]],
			paths = [[0, 1, 2]], convexity = 10); 
	}
	}
	}
}


//===========================================
// General stuff
pi = 3.1415926;
$fn = 30; // facet resolution
alpha = 180 * $t; // for animation
//===========================================


//===========================================
// Note: The gears are offset by 90 degrees.  
// For them to mesh with this phasing, they need to have
// number of teeth = 4*n + 2, where n is an integer.  
// First few options are 6, 10, 14, 18, 22, 26, 30...
//
// The gear parameters determine the rotor parameters, 
// so let's start by defining them:
//
mm_per_tooth = 5; // for timing gears
number_of_teeth = 22; // for timing gears, pick one: 6, 10, 14, 18, 22, 26, etc.
thickness = 6; 
hole_diameter = 0;
twist = 0;
teeth_to_hide = 0;
pressure_angle = 28;
clearance = 0.3;
backlash = 0.2;
//===========================================


//===========================================
// Now determine and/or set the rotor parameters
r =  mm_per_tooth * number_of_teeth / pi / 4; // this is one quarter of pitch radius of timing gears
R = 4*r; // big R for eip- and hypo- trochoid shapes in rotor


rotor_thickness = 80;
n_wedge = 80; // number of wedges in a rotor quadrant
r_bore = 4; // half-side of square rotor bore
rotor_twist = 60;
shaft_dia = 12;
shaft_length = 3;


module rootsRotor(R, r, n, p, thickness, twist, fins) {
	union() {
		for( i = [0]){//:fins-1] ) {
	//		rotate([0, 0, i*(360/fins)]) hypotrochoidLinear(R, r, r, p*4, p, thickness, twist);
		//	rotate([0, 0, i*(360/fins)+(180/fins)]) epitrochoidLinear(R, r, r, p*4, p, thickness, twist);
		}
		for( i = [0:fins-1] ) {
			rotate([0, 0, i*(360/fins)]) //intersection() {
				//cube([R,R,R]);
			//	linear_extrude( thickness )
			//		polygon([[0,0],[r*(fins*2),0],[cos(180/fins)*r*(fins*2),sin(180/fins)*r*(fins*2)]]);
			
			///	hypotrochoid(r*(fins*2), r, r, p*4, thickness);
				hypotrochoidLinear(r*(fins*2), r, r, p*(fins*2), p, thickness, twist);
			//}
			rotate([0, 0, i*(360/fins)+(180/fins)]) // intersection() {
			//	linear_extrude( thickness )
			//		polygon([[0,0],[r*(fins*4),0],[cos(180/fins)*r*(fins*4),sin(180/fins)*r*(fins*4)]]);
			//	epitrochoid(r*(fins*2), r, r, p*4, thickness);
				epitrochoidLinear(r*(fins*2), r, r, p*(fins*2), p, thickness, twist);
			//}
		}
		//rotate([0, 0, 180]) hypotrochoidLinear(R, r, d, n, p, thickness, twist);
		//rotate([0, 0, 270]) epitrochoidLinear(R, r, d, n, p, thickness, twist);
	}
}
fin_count = 2 ;
a = 0;

rotate([0,0,a]) 
	rootsRotor(R, r, 4*n_wedge, n_wedge, rotor_thickness,  -rotor_twist, fin_count);
rotate([0,0,90/fin_count]) translate([fin_count*R,0,0]) rotate([0,0,-a+180+90/fin_count])
rootsRotor(R, r, 4*n_wedge, n_wedge, rotor_thickness,  rotor_twist, fin_count);