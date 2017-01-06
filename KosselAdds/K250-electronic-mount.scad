// K250-electronic-mount (RAMPS)
// thingiverse: TBD
// License: LGPL
// Kai Dupke, 2014-11-27
//
// just another electronic mount for the K250 by Ultibots
//
// history:
// Kai Dupke, 2014-12-01
//		add foundation & support to fan
//		add brim shims
// Kai Dupke, 2014-11-28
//		turn board around to give USB plug room,
//		make plate smaller and lower mounts,
//		
// Kai Dupke, 2014-11-27
//		initial version


// make circles round (>100) or not (<50)
$fn=150;

// a little bit extra to make sure holes are not too tight
X=0.1;
mils=0.0254;


m5_diameter = 5.2 ;
m5_washer_diameter = 10.5 ;
m5_nut_diameter = 9.4 ;

m3_diameter = 3.3 ;
m3_nut_diameter = 6.6 ;


m2_diameter = 2.1 ;
m2_nut_diameter = 4.2 ;


x1=135;
y1=60+2+4+45 ;
l1=y1/cos(30);
z=47;
x2=x1+y1;

thick=3;
thick_ear=4;

r=2;

screw_d=m5_diameter;
screw_z=34+screw_d/2;

ear_width=25;
wing_width=20;

mount_h=4;
mount_hole_d=m3_diameter;
mount_top_d=mount_hole_d+2;
mount_base_d=2*mount_top_d;

trinket_mount_h=4;
trinket_mount_hole_d=m2_diameter;
trinket_mount_top_d=trinket_mount_hole_d+2;
trinket_mount_base_d=2*trinket_mount_top_d;

fan_size=40;
fan_frame=fan_size+2*3;
fan_hole=fan_size-2;
fan_r=4;
fan_thick=3;
fan_mounts=32.5;
fan_d=4;


screw=3+2*X;
nut_d3=m3_nut_diameter;
nut_d=nut_d3;
trinket_nut_d=m2_nut_diameter;
nut_h=20;
nut_depth=10;
nut_trap_w=8;
nut_trap_thick=3;


// settings for brim shim
brim_hight=0.4;
brim_r=10;
brims=[[-x1/2,0],[x1/2,0],[-x2/2,y1],[x2/2,y1]];


// http://blog.arduino.cc/2011/01/05/nice-drawings-of-the-arduino-uno-and-mega-2560/
// http://www.wayneandlayne.com/files/common/arduino_mega_drawing.svg
// arduino turned around by 180°
// board_origin is left down
// mount holes are counter-clockwise
// the RAMPS overhangs 8mm on the bottom

board_holes=[
				[4,4+5],
				[119,96+5],
				[119,4+5],
				[4,96+5]
				/*[mils*550,mils*100],
				[mils*3800,mils*100],
				[mils*3550,mils*2000],
				[mils*600,mils*2000]*/
				];
trinket_origin = [-27,92];			
trinket_board_holes=[
				[-21.59/2, -11.43/2],
				[+21.59/2,  11.43/2],
				[+21.59/2, -11.43/2],
				[-21.59/2,  11.43/2] ];
				
board_origin=[-x1/2+7,1+5]; //keep 1mm distance to the edge

plate_openings=[
				[[-x1/2+10+10,15+15],[-x1/2-20,y1-30],[15,y1-20]],
				[[-10,25],[x1/2-15,30],[x1/2+25,y1-20]]
				];
//main_thing();

// main
//puzzle = false ;

module main_thing_puzzle() {
	yFemaleCut(offset = 30, cut = yCut1)
		main_thing();
	yFemaleNegCut(offset = -30, cut = yCut1)
		main_thing();
		
	yMaleCut(offset = 30, cut = yCut1)
		yMaleNegCut(offset = -30, cut = yCut1)
			main_thing();
}

module main_thing() {
	union() {
		plate();
		ears();
		mounts();
		trinket_mounts();
		fan_mount();
	//	brim(brims);
	}
}

module fan_mount() {
	// -X to make it part of the plate
	translate([-fan_frame/2,y1+4,0.1])
		rotate([90,0,0])
			fan_frame();		
}

module fan_frame() {
	difference() {
		union() {
			difference(){
				union() {
					hull() {
						translate ([0,0]) cube ([fan_r,fan_r,1*fan_thick]);
						translate ([fan_frame-fan_r,0]) cube ([fan_r,fan_r,1*fan_thick]);
						translate ([fan_frame-fan_r,fan_frame-fan_r]) cylinder (r=fan_r,1*fan_thick);
						translate ([fan_r,fan_frame-fan_r]) cylinder (r=fan_r,1*fan_thick);
					}

					// some foundation
					difference() {
						translate([0,0,fan_thick])
							cube([fan_frame,fan_frame/2-fan_mounts/2,fan_frame/2-fan_mounts/2]);
	
						translate([-X,fan_frame/2-fan_mounts/2+1,fan_frame/2-fan_mounts/2+fan_thick])
							rotate([0,90,0])
							cylinder(r=fan_frame/2-fan_mounts/2,fan_frame+X);
					}
				}

				translate([fan_frame/2,fan_frame/2,-0.1]) cylinder(d=fan_hole,3*fan_thick);
			}

			for (x = [(fan_frame/2-fan_hole/2)-0.1:fan_hole/14:(fan_frame/2+fan_hole/2)+0.1])
				translate([x,(fan_frame/2-fan_hole/2)-1,0])
				cube([0.75,fan_hole+2,fan_thick]);
		}


	translate([+fan_frame/2-fan_mounts/2,+fan_frame/2-fan_mounts/2,-0.10]) cylinder(d=fan_d,3*fan_thick);
	translate([+fan_frame/2+fan_mounts/2,+fan_frame/2-fan_mounts/2,-0.10]) cylinder(d=fan_d,3*fan_thick);
	translate([+fan_frame/2+fan_mounts/2,+fan_frame/2+fan_mounts/2,-0.10]) cylinder(d=fan_d,3*fan_thick);
	translate([+fan_frame/2-fan_mounts/2,+fan_frame/2+fan_mounts/2,-0.10]) cylinder(d=fan_d,3*fan_thick);

	// nut traps
	translate([+fan_frame/2-fan_mounts/2,+fan_frame/2-fan_mounts/2,fan_thick]) 
		nut(nut_d);

	translate([+fan_frame/2+fan_mounts/2,+fan_frame/2-fan_mounts/2,fan_thick]) 
		nut(nut_d);
	}
}


	stampSize = [500,500,100];
	kerf = -0.45;
	cutSize = 10;
	yCut1 = [10,100];
include <puzzlecutlib.scad>

/*module plate_puzzle() {
	yFemaleCut(offset = 30, cut = yCut1)
		plate2();
	yFemaleNegCut(offset = -30, cut = yCut1)
		plate2();
		
	yMaleCut(offset = 30, cut = yCut1)
		yMaleNegCut(offset = -30, cut = yCut1)
			plate2();
}*/
	
module plate() {
		difference() {
			hull() {
				translate ([+x1/2-r,0+r,0]) cylinder (r=r,thick);
				translate ([+x1/2-r,0+r,0]) rotate ([0,0,60]) translate ([+l1,0,0]) cylinder (r=r,thick);

				translate ([-x1/2+r,0+r,0]) cylinder (r=r,thick);
				translate ([-x1/2+r,0+r,0]) rotate ([0,0,120]) translate ([+l1,0,0]) cylinder (r=r,thick);
			}
		//	translate([-40,-10,-0.1]) cube([80,200,thick+0.2]);
			opening(plate_openings,board_holes,trinket_board_holes);
		}
}


module opening(openings,points,points2) {
	for (holes = openings) {
		hull() {
			for (hole = holes) translate ([hole[0],hole[1],-0.10]) cylinder (r=2*r,thick+0.2);
		}
	}
	
	
	for (point = points) {
		translate([board_origin[0]+point[0],board_origin[1]+point[1],-0.1]) {
			cylinder(d=mount_hole_d,h=mount_h+0.2);
		
			nut(nut_d);	
		}
	}
	
	
	for (point = points2) 
		translate([board_origin[0]+trinket_origin[0]+point[0],board_origin[1]+trinket_origin[1]+point[1],-0.1]){
			if(sign(point[0]) == 1) {
				cylinder(d=trinket_mount_hole_d,h=trinket_mount_h+0.2);
		
				nut(trinket_nut_d);	
			}
		}
}

module mounts(points=board_holes) {
	for (point = points)
		translate([board_origin[0]+point[0],board_origin[1]+point[1],thick]) mount();
}

module trinket_mounts(points=trinket_board_holes) {
	for (point = points) 
		translate([board_origin[0]+trinket_origin[0]+point[0],board_origin[1]+trinket_origin[1]+point[1],thick]) mount2(sign(point[0]) == -1);
}


module mount() {
	difference() {
		cylinder(d1=mount_base_d,d2=mount_top_d,h=mount_h);
		translate([0,0,-0.1]) cylinder(d=mount_hole_d,h=mount_h+0.2);
		translate([0,0,-thick-0.1])	nut(nut_d);	
	}
}

module mount2(val) {
	union() {
		if( val == true ) {
			translate([0,0,-0.1]) cylinder(d=trinket_mount_hole_d-0.2,h=mount_h+2.2);
		}
		difference() {
			cylinder(d1=trinket_mount_base_d,d2=trinket_mount_top_d,h=trinket_mount_h);
			if( val == false ) {
				translate([0,0,-0.1]) cylinder(d=trinket_mount_hole_d,h=mount_h+0.2);
				translate([0,0,-thick-0.1])	nut(trinket_nut_d);	
			}
		}
	}
}

module ears() {
	translate ([x1/2-r,r,0])
		rotate ([0,0,60]) ear();
	translate ([x1/2-r,r,0])
		rotate ([0,0,0]) wing();

	translate ([-x1/2+r,r,0])
		rotate ([0,0,120]) ear();
	translate ([-x1/2+r,r,0])
		rotate ([0,0,180]) wing();

	translate ([+x1/2-r,0+r,0]) rotate ([0,0,60]) translate ([+l1,0,0])
		rotate ([0,0,-180]) ear();
	translate ([+x1/2-r,0+r,0]) rotate ([0,0,60]) translate ([+l1,0,0])
		rotate ([0,0,-60]) wing();

	translate ([-x1/2+r,0+r,0]) rotate ([0,0,120]) translate ([+l1,0,0])
		rotate ([0,0,-180]) ear();
	translate ([-x1/2+r,0+r,0]) rotate ([0,0,120]) translate ([+l1,0,0])
		rotate ([0,0,60]) wing();
}

module wing() {
	hull() {
		translate ([0,0,0]) cylinder (r=r,thick);
//		translate ([0,0,screw_z]) sphere (r=r); // don't get the ears higher than the screw hole
		translate ([0,0,z-r]) sphere (r=r);
		translate ([-wing_width,0,0]) cylinder (r=r,thick);
	}

}


module ear() {
	difference() {
		hull() {
			for ( point = [[0,0],[ear_width-2*r,0]]) {
				translate (point) cylinder (r=r,thick_ear);
				translate ([point[0],point[1],z-r]) sphere (r=r);
			}
		}

	translate ([ear_width/2-r,thick_ear/2,screw_z])
		rotate ([90,0,0])
		cylinder (r=screw_d/2+X,thick_ear);
	}
}



module nut(dia) {
	hull() {
		cylinder(d=dia,thick,$fn=6);
		translate([0,0,thick]) cylinder(d1=dia,d2=0,thick/4,$fn=6);
	}
}

module brim(brim_pos) {
	for (pos = brim_pos) {
		translate (pos) cylinder(r=brim_r,brim_hight);
	}
}
