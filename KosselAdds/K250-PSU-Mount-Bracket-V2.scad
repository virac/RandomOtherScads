// K250-PSU-Mount-Bracket
// thingiverse: 619430
// License: LGPL
// Kai Dupke, 2014-12-15
//
// Mounts for the K250 (or other standard) PSU
//
// history:
// Kai Dupke, 2015-01-03
//		adjust offset, make holes wider
// Kai Dupke, 2014-12-29
//		round it
// Kai Dupke, 2014-12-29
//		initial version


$fn=25; // make circles round (>=60) or not (<60), for testing 10 is good 

X=0.25; // a little bit extra to make sure holes are not too tight



thick=4; // makes a regular M5x10 fit well for the frame
wing_thick=3;

psu_l=25+10+10;
psu_w=15;
psu_screw=4;
psu_hole=[10,10+25];

frame_l=20+20+20;
frame_w=15;
frame_screw=5;
frame_hole=[10,frame_l-10];
frame_offset=5; 

distance=45;


// settings for brim shim
brim_hight=0.4;
brim_r=6;
brims=[
		[0,0],
		[0,psu_l],
		[distance,frame_offset],
		[distance,frame_offset+frame_l],
		];

// mount
// PSU side
difference(){
	hull(){
		translate([thick/2,thick/2,thick])
			cylinder(d=thick,0.1);

		translate([thick/2,thick/2,thick+psu_w-thick/2])
			sphere(d=thick);

		translate([thick/2,psu_l-thick/2,thick])
			cylinder(d=thick,0.1);

		translate([thick/2,psu_l-thick/2,thick+psu_w-thick/2])
			sphere(d=thick);
	}

	for (y = psu_hole) 
		translate([-X,y,psu_w/2+thick])
		rotate([0,90,0])
		cylinder(d=psu_screw+X,thick+2*X);
}


difference(){
	translate([thick,thick,thick])
		cube([thick,psu_l-thick,thick]);

	translate([thick+thick,thick-X,thick+thick])
		rotate([-90,0,0])
		cylinder(r=thick,psu_l-thick+2*X);
	
}


// stabilize wing
// frame side

hull(){
	translate([thick/2,psu_l-thick/2,thick])
		cylinder(d=thick,0.1);

	translate([thick/2,psu_l-thick/2,psu_w-thick/2+thick])
		sphere(d=thick);

	translate([distance/2,frame_offset/2+psu_l+(frame_l-psu_l)/2-wing_thick/2,thick])
		cylinder(d=wing_thick,0.10);
}



// mount
// frame side
	difference(){
		hull(){
			translate([distance-thick/2,frame_offset+thick/2,thick])
				cylinder(d=thick,0.1);

			translate([distance-thick/2,frame_offset+thick/2,thick+frame_w-thick/2])
				sphere(d=thick);

			translate([distance-thick/2,frame_offset+frame_l-thick/2,thick])
				cylinder(d=thick,0.1);

			translate([distance-thick/2,frame_offset+frame_l-thick/2,thick+frame_w-thick/2])
				sphere(d=thick);
		}

		for (y = frame_hole) 
			translate([distance-thick-X,y+frame_offset,frame_w/2+thick])
			rotate([0,90,0])
			cylinder(d=frame_screw+X,thick+2*X);
	}



difference(){
	translate([distance-2*thick,frame_offset,thick])
		cube([thick,frame_l-thick,thick]);

	translate([distance-2*thick,frame_offset-X,thick+thick])
		rotate([-90,0,0])
		cylinder(r=thick,frame_l-thick+2*X);
	
}

// stabilize wing
// Frame side
hull(){
	translate([distance/2,frame_offset/2+wing_thick/2,thick])
		cylinder(d=wing_thick,0.1);

	translate([distance-thick/2,frame_offset+thick/2,thick])
		cylinder(d=thick,0.1);

	translate([distance-thick/2,frame_offset+thick/2,thick+frame_w-thick/2])
		sphere(d=thick);
}




// connection plate
hull(){
	translate([thick/2,psu_l-thick/2,0])
		cylinder(d=thick,thick);

	translate([thick/2,thick/2,0])
		cylinder(d=thick,thick);

	translate([distance-thick/2,frame_offset+thick/2,0])
		cylinder(d=thick,thick);

	translate([distance-thick/2,frame_offset+frame_l-thick/2,0])
		cylinder(d=thick,thick);
}

brim(brims);

module brim(brim_pos) {
	for (pos = brim_pos) {
		translate (pos) cylinder(r=brim_r,brim_hight);
	}
}
