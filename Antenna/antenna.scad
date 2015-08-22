
include <puzzlecutlib.scad>

m3_diameter = 3.3 ;
m3_cap_diameter = 5.7 ;
m3_cap_thickness = 3.0 ;
m3_nut_diameter = 6.6 ;
m3_nut_thickness = 2.5 ;
m3_tap_diameter = 2.5 ;
m3_washer_diameter = 6.8 ;

module beveled_cube( dim, r, c=false, n = $fn) {
	hull() 
		for( i = [-1,1] ) for( j=[-1,1]) for(k=[-1,1])
			translate([i*(dim[0]/2-r),j*(dim[1]/2-r),k*(dim[2]/2-r)]) 
				sphere(r,center=c,$fn=n);
	
	/*minkowski() {
		cube(dim-[2*r,3*r,2*r], center=c );
		sphere(r,center=c,$fn=n);
	}*/
}
module beveled_cube_top( dim, r, center=false, n = $fn) {
	intersection(){
		minkowski() {
			translate([0,0,-r])cube(dim-[2*r,2*r,0], center );
			sphere(r,center,$fn=n);
		}
		cube(dim, center );
	}
}
module beveled_cube_LR( dim, r, center=false, n = $fn) {
	intersection(){
		minkowski() {
			translate([0,0,0])cube(dim-[2*r,0,2*r], center );
			sphere(r,center,$fn=n);
		}
		cube(dim, center );
	}
}

module antenna_base( gap_x, gap_y, overshoot_x, wire ) {
	second_stage_angle = atan2((gap_x+m3_diameter*(5/6)),(gap_y-m3_diameter*(5/6))) ;
	second_stage_length = (gap_y-m3_diameter/2)/cos(second_stage_angle) ;

	difference(){
		beveled_cube([gap_x+ 2* overshoot_x, gap_y*4,5],r=2, center = true,n = 16 );
		//cube([gap_x+ 2* overshoot_x, gap_y*2,5], center = true );
		union() {
			translate([-gap_x/2,-gap_y*3/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([-gap_x/2,-gap_y/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([-gap_x/2, gap_y/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([-gap_x/2, gap_y*3/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([ gap_x/2,-gap_y*3/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([ gap_x/2,-gap_y/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([ gap_x/2, gap_y/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			translate([ gap_x/2, gap_y*3/2,-5]) cylinder( r = m3_diameter/2,h = 10, $fn = 16);
			
			translate([-(gap_x/2+m3_diameter/2+wire/4),0,2.55]) rotate([90,0,0]) {
				hull() {
					cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
				}
				translate([0,0,(gap_y+2)/2]) rotate([0,second_stage_angle,0]) translate([0,0,second_stage_length/2]) hull() {
					cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
				}
				translate([0,0,-(gap_y+2)/2]) rotate([0,180-second_stage_angle,0]) translate([0,0,second_stage_length/2]) hull() {
					cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
				}
				
				
				translate([(gap_x/2+m3_diameter/2+wire/4)*2,0,(gap_y*3/2+1)]) hull() {
					cylinder( r = wire/2,h = 4, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = 4, $fn = 16,center = true);
				}
				translate([(gap_x/2+m3_diameter/2+wire/4)*2,0,-(gap_y*3/2+1)]) hull() {
					cylinder( r = wire/2,h = 4, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = 4, $fn = 16,center = true);
				}
			}
			translate([(gap_x/2+m3_diameter/2+wire/4),0,2.55]) rotate([90,0,0]) {
				hull() {
					cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
				}
				translate([0,0,(gap_y+2)/2]) rotate([0,-second_stage_angle,0]) translate([0,0,second_stage_length/2]) hull() {
					cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
				}
				translate([0,0,-(gap_y+2)/2]) rotate([0,180+second_stage_angle,0]) translate([0,0,second_stage_length/2]) hull() {
					cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = second_stage_length, $fn = 16,center = true);
				}
				
				translate([-(gap_x/2+m3_diameter/2+wire/4)*2,0,(gap_y*3/2+1)]) hull() {
					cylinder( r = wire/2,h = 4, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = 4, $fn = 16,center = true);
				}
				translate([-(gap_x/2+m3_diameter/2+wire/4)*2,0,-(gap_y*3/2+1)]) hull() {
					cylinder( r = wire/2,h = 4, $fn = 16,center = true);
					translate([0,-wire*1.4,0]) cylinder( r = wire/2,h = 4, $fn = 16,center = true);
				}
			}
			
			/*translate([gap_x/2+overshoot_x-5,-gap_y-10,0]) cube([2,10,15],center=true);
			translate([-(gap_x/2+overshoot_x-5),-gap_y-10,0]) cube([2,10,15],center=true);
			translate([gap_x/2+overshoot_x-5,gap_y+10,0]) cube([2,10,15],center=true);
			translate([-(gap_x/2+overshoot_x-5),gap_y+10,0]) cube([2,10,15],center=true);*/
			translate([0,gap_y*2-8,0]) hull(){
				cube([8,2,15],center=true);
				cylinder(r = 5/2, h = 15,center = true, $fn=16);
			}
			translate([0,-(gap_y*2-8),0])  hull(){
				cube([8,2,15],center=true);
				cylinder(r = 5/2, h = 15,center = true, $fn=16);
			}
			
		}
	}
}

module antenna_center( thickness, gap_x, gap_y, y_length, overshoot_x, wire, feeler_length,feeler_sep ) {
	second_stage_angle = atan2((gap_x+m3_diameter*(5/6)),(gap_y-m3_diameter*(5/6))) ;
	second_stage_length = (gap_y-m3_diameter/2)/cos(second_stage_angle) ;
	feeler_angle = asin((feeler_sep-m3_diameter/2)/feeler_length);
	
	xFemaleNegCut(offset = (y_length/2-kerf), cut = [0]) 
	xFemaleCut(offset = -(y_length/2-kerf), cut = [0]) 
		difference(){
			union() {
				beveled_cube([gap_x+ 2* overshoot_x, y_length,thickness],r=1, c = true,n = 16 );
				cube([cutSize*2, y_length,thickness],center = true );
			}
			//cube([gap_x+ 2* overshoot_x, gap_y*2,5], center = true );
			union() {
				translate([-gap_x/2,0,-thickness]) cylinder( r = m3_diameter/2,h = thickness+5, $fn = 16);
				difference() {
					translate([-gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_nut_diameter/2,h = m3_nut_thickness, $fn = 6);
					translate([-gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_diameter/2+0.5,h = m3_nut_thickness-0.1, $fn = 16);
				}
				translate([ gap_x/2,0,-thickness]) cylinder( r = m3_diameter/2,h = thickness+5, $fn = 16);
				difference() {
					translate([ gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_nut_diameter/2,h = m3_nut_thickness, $fn = 6);
					translate([ gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_diameter/2+0.5,h = m3_nut_thickness-0.1, $fn = 16);
				}
				
				translate([-(gap_x/2-m3_diameter/2-wire/4),0,thickness/2-wire/4]) rotate([90,0,0]) {
					cylinder( r = wire/2,h = (y_length+2), $fn = 16,center = true);
				}
				translate([-(gap_x/2-m3_diameter/2-wire/4),0,thickness/2+wire/3]) rotate([90,0,0]) {
					hull() {
						translate([0,0,y_length/2]) cylinder( r = wire/2,h = (y_length+2)/2, $fn = 16,center = true);
						translate([0,-wire*1.4,y_length/2]) cylinder( r = wire/2,h = 2, $fn = 16,center = true);
					}
				}
				translate([-(gap_x/2-m3_diameter/2-wire/4),0,thickness/2+wire/3]) rotate([90,0,0]) {
					hull() {
						translate([0,0,-y_length/2]) cylinder( r = wire/2,h = (y_length+2)/2, $fn = 16,center = true);
						translate([0,-wire*1.4,-y_length/2]) cylinder( r = wire/2,h = 2, $fn = 16,center = true);
					}
				}
				
				translate([(gap_x/2-m3_diameter/2-wire/4),0,thickness/2-wire/4]) rotate([90,0,0]) {
					cylinder( r = wire/2,h = (y_length+2), $fn = 16,center = true);
				}
				translate([(gap_x/2-m3_diameter/2-wire/4),0,thickness/2+wire/3]) rotate([90,0,0]) {
					hull() {
						translate([0,0,y_length/2]) cylinder( r = wire/2,h = (y_length+2)/2, $fn = 16,center = true);
						translate([0,-wire*1.4,y_length/2]) cylinder( r = wire/2,h = 2, $fn = 16,center = true);
					}
				}
				translate([(gap_x/2-m3_diameter/2-wire/4),0,thickness/2+wire/3]) rotate([90,0,0]) {
					hull() {
						translate([0,0,-y_length/2]) cylinder( r = wire/2,h = (y_length+2)/2, $fn = 16,center = true);
						translate([0,-wire*1.4,-y_length/2]) cylinder( r = wire/2,h = 2, $fn = 16,center = true);
					}
				}
			}
		}
}

module antenna_block( thickness, gap_x, gap_y, y_length, overshoot_x, wire, feeler_length,feeler_sep ) {
	second_stage_angle = atan2((gap_x+m3_diameter*(5/6)),(gap_y-m3_diameter*(5/6))) ;
	second_stage_length = (gap_y-m3_diameter/2)/cos(second_stage_angle) ;
	feeler_angle = asin((feeler_sep-m3_diameter/2)/feeler_length);
	
	feeler_drop = thickness/2-wire/3 ;
	bus_drop = thickness/2-wire/3 ;
	
	
	xFemaleNegCut(offset = (y_length/2-kerf), cut = [0]) 
	xFemaleCut(offset = -(y_length/2-kerf), cut = [0]) 
		difference(){
			union() {
				beveled_cube([gap_x+ 2* overshoot_x, y_length,thickness],r=thickness/4, c = true,n = 16 );
				cube([cutSize*2, y_length,thickness],center = true );
			}
			//cube([gap_x+ 2* overshoot_x, gap_y*2,5], center = true );
			union() {
				translate([0,0,-thickness]) cylinder( r = m3_diameter/2,h = thickness+5, $fn = 16);
				difference() {
					translate([0,0,-thickness/2-0.1]) cylinder( r = m3_washer_diameter/2,h = m3_cap_thickness+0.5+0.1, $fn = 16);
					translate([0,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_diameter/2+0.5,h = m3_cap_thickness+0.4, $fn = 16);
				}
				translate([-gap_x/2,0,-thickness]) cylinder( r = m3_diameter/2,h = thickness+5, $fn = 16);
				difference() {
					translate([-gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_nut_diameter/2,h = m3_nut_thickness, $fn = 6);
					translate([-gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_diameter/2+0.5,h = m3_nut_thickness-0.1, $fn = 16);
				}
				translate([ gap_x/2,0,-thickness]) cylinder( r = m3_diameter/2,h = thickness+5, $fn = 16);
				difference() {
					translate([ gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_nut_diameter/2,h = m3_nut_thickness, $fn = 6);
					translate([ gap_x/2,0,-thickness/2]) rotate([0,0,90]) cylinder( r = m3_diameter/2+0.5,h = m3_nut_thickness-0.1, $fn = 16);
				}
				
				translate([0,0,thickness/2-m3_diameter/4+0.1])cube([m3_diameter*2,m3_diameter*2,m3_diameter/2+0.2],center=true);
				
				translate([-(gap_x/2+m3_diameter/2+wire/4),0,bus_drop]) rotate([90,0,0]) {
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
						translate([0,-wire*0.9,0]) cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
					}
				}
					
				translate([-(gap_x/2),m3_diameter/2+wire/2,feeler_drop]) rotate([90,0,90-feeler_angle]) translate([0,0,-(y_length-m3_diameter/2-wire/2)]){
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = y_length, $fn = 16);
						cylinder( r = wire/2,h = y_length, $fn = 16);
					}
				}
				translate([-(gap_x/2),-(m3_diameter/2+wire/2),feeler_drop]) rotate([90,0,90+feeler_angle]) translate([0,0,-(y_length-m3_diameter/2-wire/2)]){
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = y_length, $fn = 16);
						cylinder( r = wire/2,h = y_length, $fn = 16);
					}
				}
				translate([-(gap_x/2-m3_diameter/2-wire/4),0,feeler_drop]) rotate([90,0,0]) {
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = m3_diameter, $fn = 16,center=true);
						cylinder( r = wire/2,h = m3_diameter, $fn = 16,center = true);
					}
				}
				
				translate([(gap_x/2+m3_diameter/2+wire/4),0,bus_drop]) rotate([90,0,0]) {
					hull() {
						cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
						translate([0,-wire*0.9,0]) cylinder( r = wire/2,h = gap_y+2, $fn = 16,center = true);
					}
				}
				
				translate([(gap_x/2),m3_diameter/2+wire/2,feeler_drop]) rotate([90,0,90+feeler_angle]) translate([0,0,(-m3_diameter/2-wire/2)]){
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = y_length, $fn = 16);
						cylinder( r = wire/2,h = y_length, $fn = 16);
					}
				}
				translate([(gap_x/2),-(m3_diameter/2+wire/2),feeler_drop]) rotate([90,0,90-feeler_angle]) translate([0,0,(-m3_diameter/2-wire/2)]){
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = y_length, $fn = 16);
						cylinder( r = wire/2,h = y_length, $fn = 16);
					}
				}
				translate([(gap_x/2-m3_diameter/2-wire/4),0,feeler_drop]) rotate([90,0,0]) {
					hull() {
						translate([0,wire*0.9,0]) cylinder( r = wire/2,h = m3_diameter, $fn = 16,center=true);
						cylinder( r = wire/2,h = m3_diameter, $fn = 16,center = true);
					}
				}
			}
		}
}


module antenna_connector( block_y_length,spcaing,thickness ) {
	connector_y_length = spcaing - block_y_length;
	xMaleNegCut(offset = -connector_y_length/2+abs(kerf), cut = [0]) 
	xMaleCut(offset = connector_y_length/2-abs(kerf), cut = [0]) 
	union() {
		//cube([cutSize*2, connector_y_length+(cutSize)*2,5],center = true );
	
		beveled_cube([cutSize*2, connector_y_length-(cutSize)*2,thickness], r=thickness/4, c=true, n = 16);
		translate([0,connector_y_length/2+cutSize,0]) hull() {
			cube([cutSize*2, cutSize,thickness],center = true );
			translate([0,-cutSize*2,0]) beveled_cube([cutSize*2,(cutSize*2),thickness], r=thickness/4, c=true, n = 16);
		}
		
		translate([0,-(connector_y_length/2+cutSize),0]) hull() {
			cube([cutSize*2, cutSize,thickness],center = true );
			translate([0,cutSize*2,0]) beveled_cube([cutSize*2,(cutSize*2),thickness], r=thickness/4, c=true, n = 16);
		}
	}
}

module antenna_connector_hook( thickness ) {
	xMaleCut(offset = -abs(kerf), cut = [0]) 
	difference() {
		translate([0,cutSize,0]) hull() {
			cube([cutSize*2, cutSize,thickness],center = true );
			translate([0,-cutSize*1.5,0]) beveled_cube([cutSize*2,(cutSize*2),thickness], r=thickness/4, c=true, n = 16);
		}
		
		union() {
			translate([0,-cutSize*2/3,0])
				cube([cutSize, cutSize*2/3,thickness+0.2],center = true );
		}
	}
}

wire_10awg = 2.59 ;
wire_12awg = 2.05 ;
wire_14awg = 1.63 ;
wire_16awg = 1.29032 ;
wire_18awg = 1.02362 ;
wire_20awg = 0.81280 ;
wire_22awg = 0.64516 ;

function toMMfromIN( in ) = in / 0.039370;

					
					
					
					
wire_used = wire_12awg;

antenna_angle = 30 ;
antenna_length = toMMfromIN(7 );
antenna_sep = toMMfromIN(3 );

antenna_gap = toMMfromIN( 1 );
center_gap = toMMfromIN( 0.6 );
antenna_spacing = toMMfromIN( 5.25 );

stampSize = [500,500,100];		//size of cutting stamp (should cover 1/2 of object)

cutSize = antenna_gap/5;	//size of the puzzle cuts

xCut1 = [-antenna_gap/2, antenna_gap/2];			//locations of puzzle cuts relative to Y axis center
centerCut1 = [-antenna_gap/2, antenna_gap/2];			//locations of puzzle cuts relative to Y axis center
centerCut2 = [0];			//locations of puzzle cuts relative to Y axis center

kerf = -0.25;	//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces
					
					
block_length = max( antenna_spacing/8, m3_washer_diameter*2+cutSize*2 );
connector_length = antenna_spacing-block_length;

block_thickness = 8 ;

	//antenna_connector(block_length,antenna_spacing/2);
//cube([5,5,5],center=true);

antenna_center( block_thickness, center_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );

//	antenna_connector(block_length,antenna_spacing/2,block_thickness);
/*translate([0,-antenna_spacing/4,0]) 
	antenna_connector(block_length,antenna_spacing/2);
translate([0,antenna_spacing/4,0]) 
	antenna_connector(block_length,antenna_spacing/2);
	
	
translate([0,antenna_spacing*3/2,0]) 
	antenna_block( block_thickness, antenna_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );

translate([0,antenna_spacing/2+connector_length/2+block_length/2,0]) 
	antenna_connector(block_length,antenna_spacing);
	
translate([0,antenna_spacing/2,0]) 
	antenna_block( block_thickness, antenna_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );
	
translate([0,-antenna_spacing*3/2,0]) 
	antenna_block( block_thickness, antenna_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );

translate([0,-(antenna_spacing/2+connector_length/2+block_length/2),0]) 
	antenna_connector(block_length,antenna_spacing);
	
translate([0,-antenna_spacing/2,0]) 
	antenna_block( block_thickness, antenna_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );
/*	translate([0,block_length+5,0])
	antenna_block( block_thickness, antenna_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );
	translate([0,(block_length+5)*2,0])
	antenna_block( block_thickness, antenna_gap, antenna_spacing,block_length, block_thickness, wire_used,antenna_length,antenna_sep );
	*/
	
	
//translate([0,-(antenna_spacing*3/2+block_length/2),0]) 
//translate([block_thickness*3.5,0,0])
//	antenna_connector_hook(block_thickness);
//translate([0,(antenna_spacing*3/2+block_length/2),0]) rotate([0,0,180])
//	antenna_connector_hook(block_length,antenna_spacing);
	
//xMaleCut( offset = 0, cut = centerCut2 )
//xFemaleNegCut(offset = 0, cut = centerCut1 ) 
//xFemaleCut(offset = -antenna_spacing, cut = xCut1) 
//	xFemaleNegCut(offset = antenna_spacing, cut = xCut1) 
//		antenna_base( antenna_gap, antenna_spacing, 10, wire_used );

//translate([-antenna_gap*2,-0,0]) 
//xMaleNegCut(offset = antenna_spacing, cut = xCut1) 
//	antenna_base( antenna_gap, antenna_spacing, 10, wire_used );
