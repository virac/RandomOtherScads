
include <puzzlecutlib.scad>

function toMMfromIN( in ) = in / 0.039370;
piece_gap = toMMfromIN( 1 );

stampSize = [50,50,100];		//size of cutting stamp (should cover 1/2 of object)

cutSize = piece_gap/5;	//size of the puzzle cuts

xCut1 = [-piece_gap/2, piece_gap/2];			//locations of puzzle cuts relative to Y axis center
centerCut1 = [-piece_gap/2, piece_gap/2];			//locations of puzzle cuts relative to Y axis center
centerCut2 = [0];			//locations of puzzle cuts relative to Y axis center

kerf = -0.15;	//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces
					
					
m5_diameter = 5.2 ;
m5_washer_diameter = 10.5 ;
m5_nut_diameter = 9.4 ;

m3_diameter = 3.3 ;
m3_washer_diameter = 6.9 ;
m3_nut_diameter = 6.6 ;

module bed_support_fsr(bed_dia,arm_position) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	//xMaleNegCut(offset = -200/2+abs(kerf), cut = [0]) 
	//xMaleCut(offset = 200/2-abs(kerf), cut = [0]) 
	difference() {
		cylinder(r=support_outer_radius, h = 5);
		union() {
		//	translate([0,0,-0.1]) cylinder(r=support_inner_radius, h = 5.2);
			rotate([0,0,-30])
				translate([-support_outer_radius*1.5,-support_outer_radius,-0.1]) cube([support_outer_radius*2,support_outer_radius*2,5.2]);
			translate([-support_outer_radius,0,-0.1]) cube([support_outer_radius*2,support_outer_radius*2,5.2]);
			rotate([0,0,120]) translate([-support_outer_radius,0,-0.1]) cube([support_outer_radius*2,support_outer_radius*2,5.2]);
		}
	}
	rotate([0,0,-30]) hull(){
		translate([bed_dia/2-10,0,0]) cylinder(r=22/2+4, h = 5);
		translate([arm_position,0,0]) cylinder(r=22/2+4, h = 5);
	}
	rotate([180,0,-30]) translate([arm_position,0,0]) {
		cylinder(r=10/2, h = 2);
		difference() {
			cylinder(r=22/2+4, h = 5);
			translate([0,0,-0.1]) cylinder(r=22/2, h = 5.2);
			rotate([0,0,180]) translate([0,-5,0]) cube([20,10,10.2]);
		}
	}
	//translate([-support_outer_radius*1.5,-support_outer_radius,-0.1]) 
	xFemaleCut(offset = 1, cut = [10]) cube([support_outer_radius/2,support_outer_radius/2,5.2]);
}

module bed_support_brace(bed_dia) {
	support_outer_radius = bed_dia/3 ;
	support_inner_radius = 7.5 ;
	for( i = [0:2] ) rotate([0,0,i*120])
	difference() {
		cylinder(r=support_outer_radius, h = 5);
		union() {
			translate([0,0,-0.1]) cylinder(r=support_inner_radius, h = 5.2);
			translate([-support_outer_radius,0,-0.1]) cube([support_outer_radius*2,support_outer_radius*2,5.2]);
			rotate([0,0,120]) translate([-support_outer_radius,0,-0.1]) cube([support_outer_radius*2,support_outer_radius*2,5.2]);
		}
	}
}

module _fan_outline(fan_size, //nominsl size of fan
			fan_mounting_pitch, //pitch between mounting holes
			fan_m_hole_dia, //mounting hole diameter
			holder_thickness //user defined thickness
		 ) {
offset1 = (fan_size-(fan_mounting_pitch + fan_m_hole_dia))/2;
	linear_extrude(height = holder_thickness)
		union()
		{	
			difference()
			{
				translate([fan_m_hole_dia/2,fan_m_hole_dia/2,0])
				minkowski()
				{	
					square([fan_size - fan_m_hole_dia,fan_size - fan_m_hole_dia]);
					circle(r= fan_m_hole_dia/2, $fn=20);
				}
			
					translate([offset1,offset1,0])
					square([fan_mounting_pitch + fan_m_hole_dia,fan_mounting_pitch + fan_m_hole_dia]);
			}
		}
				
}
module _fan_cutout(fan_size, //nominsl size of fan
			fan_mounting_pitch, //pitch between mounting holes
			fan_m_hole_dia, //mounting hole diameter
			holder_thickness //user defined thickness
		 ) {
offset1 = (fan_size-(fan_mounting_pitch + fan_m_hole_dia))/2;
	linear_extrude(height = holder_thickness)
		translate([offset1,offset1,0])
			square([fan_mounting_pitch + fan_m_hole_dia,fan_mounting_pitch + fan_m_hole_dia]);	
}

module _fan_mount(
			fan_size, //nominsl size of fan
			fan_mounting_pitch, //pitch between mounting holes
			fan_m_hole_dia, //mounting hole diameter
			holder_thickness //user defined thickness
		 )
{

offset1 = (fan_size-(fan_mounting_pitch + fan_m_hole_dia))/2;
offset2 = (fan_size-(fan_mounting_pitch))/2;
offset3 = offset2 + fan_mounting_pitch;
thickness = (fan_size-fan_mounting_pitch)/2;	
			
			//difference()
			//{
			linear_extrude(height = holder_thickness)
			union()
			{	
			difference()
			{
				translate([fan_m_hole_dia/2,fan_m_hole_dia/2,0])
				minkowski()
				{	
					square([fan_size - fan_m_hole_dia,fan_size - fan_m_hole_dia]);
					circle(r= fan_m_hole_dia/2, $fn=20);
				}
			
					translate([offset1,offset1,0])
					square([fan_mounting_pitch + fan_m_hole_dia,fan_mounting_pitch + fan_m_hole_dia]);
				}
				translate([offset2,offset2,0])
				rotate([0,0,0])_corner_hole();
				translate([offset3,offset2,0])
				rotate([0,0,90])_corner_hole();
				translate([offset2,offset3,0])
				rotate([0,0,90])_corner_hole();
				translate([offset3,offset3,0])
				rotate([0,0,0])_corner_hole();
			}
      }

module _corner_hole()
{
				difference(){
					union(){
							difference(){
							square([fan_m_hole_dia + thickness,fan_m_hole_dia + thickness],center=true);
							square([(fan_m_hole_dia + thickness)/2,(fan_m_hole_dia + thickness)/2],center=false);
							translate([-(fan_m_hole_dia + thickness)/2,-(fan_m_hole_dia + thickness)/2])
							square([(fan_m_hole_dia + thickness)/2,(fan_m_hole_dia + thickness)/2],center=false);
							}
					circle(r=(fan_m_hole_dia + thickness)/2, $fn=20);
					}
					circle(r=(fan_m_hole_dia)/2, $fn=20);
				}
}


//echo(offset1,offset2,thickness);
//}

module fsr_mount( left_mount, right_mount, depth = 5 ) {
offset = 20 ;
	difference(){
		union() {
			rotate([0,0,-30]) 
				translate([0,0,4.9]) cylinder(r=22/2-0.2, h = 8.1);
			rotate([0,0,-30]) translate([0,0,0])
				rotate([0,0,180]) translate([1,-5,3.99]) intersection() {
					minkowski() {
						translate([0,0,-5]) cube([8,10,7]);
						rotate([90,0,0]) translate([5,1,0]) cylinder( r = 2, h = 0.01, $fn = 32,center=true);
					}
					difference() {
						translate([5,0,1-depth]) cube([10,10,4+depth]);
						
						translate([10,-0.5,-3]) cube([2,11,4]);
					}
				}
			if( depth >0 ) rotate([0,0,-30]) intersection() {
				minkowski(){
					hull() {
						cylinder(r = 9, h = depth-1);//cube([18,20,4]);
						
						if( left_mount == true ) {
							translate([0,-offset,2]) cube([18,19,4],center=true);
						}
						if( right_mount == true ) {
							translate([0,offset,2]) cube([18,19,4],center=true);
						}
					}
					sphere(r=1);
				}
			
				union() {
					hull() {
						cylinder(r = 9, h = depth);//cube([18,20,4]);
						
						if( left_mount == true ) {
							translate([0,-offset,2.5]) cube([20,20,5],center=true);
						}
						if( right_mount == true ) {
							translate([0,offset,2.5]) cube([20,20,5],center=true);
						}
					}
				}
			}
			if( depth >0 ) rotate([0,0,-30])
				cylinder(r1 = 9, r2 = 22/2-0.2, h = depth);
			rotate([0,0,-30]) {
				if( left_mount == true ) translate([0,-offset,5]) difference() {
					cylinder(r=m5_washer_diameter/2+2, h = 1);
					cylinder(r=m5_washer_diameter/2, h = 1.2);
				}
				if( right_mount == true ) translate([0,offset,5]) difference() {
					cylinder(r=m5_washer_diameter/2+2, h = 1);
					cylinder(r=m5_washer_diameter/2, h = 1.2);
				}
			}
				
		}
		
		//holes
		
		rotate([0,0,-30]) {
			translate([0,offset,-0.1]) cylinder(r=m5_diameter/2, h = 6.2, $fn = 12);
			translate([0,-offset,-0.1]) cylinder(r=m5_diameter/2, h = 6.2, $fn = 12);
		}
		
		rotate([0,0,-30])
			rotate([0,0,180]) translate([0,-5,9]) cube([20,10,5.2]);
		rotate([0,0,-30])
			rotate([0,0,180]) translate([16,-5,0]) cube([2,10,5.2]);
		rotate([0,0,-30]) 
			translate([0,0,9]) cylinder(r=19/2, h = 10);
	}
}

module hex_bed(bed_dia,arm_position,arm_length) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	bed_r = 133;
	cylinder(r=bed_r,h = 5);
	for( i=[ 0:2 ] ) {
		rotate([0,0,i*120-60]) translate([0,-arm_position,2.5])
			difference() {
				union() {
					cube([100,14,5],center = true);
				}
		
			union() {
				translate([ 43,0,-2.6]) cylinder(r=m3_diameter/2, h = 6.2, $fn = 12);
				translate([-43,0,-2.6]) cylinder(r=m3_diameter/2, h = 6.2, $fn = 12);
			}
		} //difference
	} // for
}

module hex_bed_clip(bed_dia,arm_position,arm_length) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	bed_r = 133;
   
   if(true) {
         rotate([0,0,-60]) translate([0,-arm_position,2.5])
      union() {
         difference() {
            for( i = [-1,1] ) translate([ i*43,1,1]) difference() {
               union() {
                  hull() {
                     difference() {
                        translate([0,2.5,0]) cube([20,27,4],center = true);
                        translate([ -i*43,-1,-5]) translate([0,arm_position,1.5]) rotate([0,0,60]) cylinder(r=bed_dia/2-4,h = 10.2,$fn=512);
                     }
                     difference() {
                        intersection() {
                           translate([0,7.5,1]) cube([15,20,5],center = true);
                           translate(-[ i*43,1,1]) translate([0,arm_position,-1]) rotate([0,0,60]) translate([0,0,-0.1])
                                 cylinder(r=bed_dia/2+4,h = 8.1,$fn=512);
                        }
                        translate([ -i*43,-1,-1-2]) translate([0,arm_position,1.5]) rotate([0,0,60]) cylinder(r=bed_dia/2,h = 7.2,$fn=512);
                     }
                     difference() {
                        translate([0,-5.5,1]) cube([15,5,4],center = true);
                        translate([ -i*43,-1,-1-2]) translate([0,arm_position,1.5]) rotate([0,0,60]) cylinder(r=bed_dia/2,h = 7.2,$fn=512);
                     }
                  }
       //           translate([0,-22/2+2.5/2,-4/2-3/2]) cube([20,2.5,3],center=true);
      //            translate([i*20/2-i*2.5/2,-3,-4/2-3/2]) cube([2.5,15,3],center=true);
               }
               hull() {
                  translate([ 0,2.5,-2.6]) cylinder(r=m3_diameter/2+.2, h = 16.2, $fn = 12);
                  translate([ 0,-3,-2.6]) cylinder(r=m3_diameter/2+.2, h = 16.2, $fn = 12);
               }
            }
      
            union() {
               
               translate([0,arm_position,-1]) rotate([0,0,60]) translate([0,0,-0.1])cylinder(r=bed_dia/2,h = 3.1,$fn=512);
               translate([0,arm_position,1.5]) rotate([0,0,60]) cylinder(r=bed_dia/2-4,h = 5.2,$fn=512);
            }
         } //difference
//         for( i = [-1,1] ) translate([ i*23,0,-1.50]) 
//            difference() {
//               hull(){
//                  translate([0,-7.5,1.5]) cube([20,5,3],center = true);
//                  translate([0,-12,3.5]) cube([10,5,7],center = true);
//               }
//               union() {
//                 translate([0,0,2]) rotate([90,0,0]) cylinder(r=m3_diameter/2, h = 20, $fn = 12);
//						translate([0,-10,2]) rotate([90,90,0]) 	cylinder(r=m3_nut_diameter/2,h=5,$fn=6);
//               }
//            }
            
//         difference() { 
//            for( i = [-1,1] ) translate([ i*23,0,-1.50]) difference() {
//               difference() {
//                  translate([0,1,2]) cube([8,6,4],center = true);
//                  translate([ -i*23,0,1.50]) translate([0,arm_position,-1.5]) rotate([0,0,60]) translate([0,0,-0.1])
//                     cylinder(r=bed_dia/2-1,h = 5.1);
//               }
//               translate([0,-1,1.5]) rotate([90,0,0]) cylinder(r=m3_diameter/2, h = 5, $fn = 12);
//            }
//            translate([0,arm_position,-1.5]) rotate([0,0,60]) translate([0,0,-0.1])cylinder(r=bed_dia/2,h = 3.1);
//         }
      }
   } else {
   rotate([0,0,-60]) translate([0,-arm_position,2.5])
      union() {
         difference() {
            cube([100,20,3],center = true);
      
            union() {
           //    translate([0,0,1.7]) cube([56,20.2,3],center = true);
               translate([0,0,-0.2]) cube([60,10,5.9],center = true);
               translate([ 43,0,-2.6]) cylinder(r=m3_diameter/2, h = 6.2, $fn = 12);
               translate([-43,0,-2.6]) cylinder(r=m3_diameter/2, h = 6.2, $fn = 12);
               
               for( i = [-1,1] ) translate([ i*23,0,-1.50]) 
                 translate([0,0,2]) rotate([90,0,0]) cylinder(r=m3_diameter/2, h = 10, $fn = 12);
               
               translate([0,arm_position,-2.5]) rotate([0,0,60]) translate([0,0,-0.1])cylinder(r=bed_dia/2+1,h = 5.2);
            }
         } //difference
         for( i = [-1,1] ) translate([ i*23,0,-1.50]) 
            difference() {
               hull(){
                  translate([0,-7.5,1.5]) cube([20,5,3],center = true);
                  translate([0,-12,3.5]) cube([10,5,7],center = true);
               }
               union() {
                 translate([0,0,2]) rotate([90,0,0]) cylinder(r=m3_diameter/2, h = 20, $fn = 12);
						translate([0,-10,2]) rotate([90,90,0]) 	cylinder(r=m3_nut_diameter/2,h=5,$fn=6);
               }
            }
            
         difference() { 
            for( i = [-1,1] ) translate([ i*23,0,-1.50]) difference() {
               difference() {
                  translate([0,1,2]) cube([8,6,4],center = true);
                  translate([ -i*23,0,1.50]) translate([0,arm_position,-1.5]) rotate([0,0,60]) translate([0,0,-0.1])
                     cylinder(r=bed_dia/2-1,h = 5.1);
               }
               translate([0,-1,1.5]) rotate([90,0,0]) cylinder(r=m3_diameter/2, h = 5, $fn = 12);
            }
            translate([0,arm_position,-1.5]) rotate([0,0,60]) translate([0,0,-0.1])cylinder(r=bed_dia/2,h = 3.1);
            
         }
      }
   }
}

module hex_bed_side_mount(bed_dia,arm_position,arm_length) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bed_r = 133;
	difference() {
	union() {
	rotate([0,0,-90]) translate([0,-arm_position+20,7.5])
		intersection() { translate([0,0,0])//[0,0,-0.1
			cube([150,60,5],center = true);

			minkowski() {
				translate([-5,0,-2.5]) cube([145,57.5,5],center = true);
			//	translate([0,0,-5]) cube([8,10,7]);
				translate([5,1,0]) sphere( r = 2.5, h = 0.01, $fn = 32,center=true);
			}
		}
		rotate([0,0,-90]) translate([0,-arm_position+20,2.5])
			cube([150,60,5],center = true);
	//	rotate([0,0,-90]) translate([0,-arm_position+30,2.5])
//			cube([150,40,5],center = true);
		
		
		rotate([0,0,-90]) translate([75-10,-arm_position,9])
			cylinder(r=m5_diameter,h=2,$fn=32);
		rotate([0,0,-90]) translate([-75+10,-arm_position,9])
			cylinder(r=m5_diameter,h=2,$fn=32);
		
	}
	union() {
		translate([0,0,5])
			cylinder(r=bed_dia/2,h=10,$fn=300);
		
		rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,-0.1])
			cylinder(r=m3_diameter/2,h=100,$fn=32);
		rotate([0,0,-90]) translate([-(50-5-m3_diameter/2),-arm_position,-0.1])
			cylinder(r=m3_diameter/2,h=100,$fn=32);
			
		rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,-0.1])
			cylinder(r=m3_nut_diameter/2,h=4,$fn=6);
		rotate([0,0,-90]) translate([-(50-5-m3_diameter/2),-arm_position,-0.1])
			cylinder(r=m3_nut_diameter/2,h=4,$fn=6);
			
		rotate([0,0,-90]) translate([75-10,-arm_position,0])
			cylinder(r=m5_diameter/2,h=100,$fn=32);
		rotate([0,0,-90]) translate([-75+10,-arm_position,0])
			cylinder(r=m5_diameter/2,h=100,$fn=32);
			
		rotate([0,0,-90]) translate([75-10,-arm_position,2.5])
			cube([20+0.4,20+0.4,5.2],center=true);
		rotate([0,0,-90]) translate([-75+10,-arm_position,2.5])
			cube([20+0.4,20+0.4,5.2],center=true);
			
		//hook for center support
		rotate([0,0,-90]) translate([0,-arm_position+45,5-1])
			cube([5,10.1,2.1],center = true);
			
			
			
			//future dev (add a lower support
			
		rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position+30,-0.1])
			cylinder(r=m5_diameter/2,h=100,$fn=32);
		rotate([0,0,-90]) translate([-(50-5-m3_diameter/2),-arm_position+30,-0.1])
			cylinder(r=m5_diameter/2,h=100,$fn=32);
			
		rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position+30,5-2.7])
			cylinder(r=m5_nut_diameter/2,h=4,$fn=6);
		rotate([0,0,-90]) translate([-(50-5-m3_diameter/2),-arm_position+30,5-2.7])
			cylinder(r=m5_nut_diameter/2,h=4,$fn=6);
	}
	}
	
	/*difference() {
		union() {
			rotate([0,0,-90]) translate([75+15,-arm_position,0]){
				translate([0,0,2.5])
					cube([20,20,4.5],center=true);//20,20,5
				translate([0,0,4.5-0.1])//0,0,5-0.1
					cylinder(r=m5_diameter-0.2,h=1.1,$fn=32);
			}
			rotate([0,0,-90]) translate([-75-15,-arm_position,0]) {
				translate([0,0,2.5])
					cube([20,20,5],center=true);
				translate([0,0,5-0.1])
					cylinder(r=m5_diameter-0.1,h=1.1,$fn=32);
			}
		}
		union() {
			rotate([0,0,-90]) translate([75+15,-arm_position,-0.1])
				cylinder(r=m5_diameter/2+0.2,h=10.1,$fn=32);//-0.1
			rotate([0,0,-90]) translate([-75-15,-arm_position,-0.1])
				cylinder(r=m5_diameter/2+0.2,h=10.1,$fn=32);//-0.1
		}
	}*/
}


module hex_bed_corner_mount(bed_dia,arm_position,arm_length,use_fan_port,fan_port_diameter) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bar_length = abs(150-40-arm_length)/2 ;
	bed_r = 133;
   
   thickness = 4 ;
	difference() {
		union() {
			rotate([0,0,-90]) translate([75-20/2,-arm_position,thickness/2])
				translate([bar_length/2-10+0.2,-0.2,0])//[0,0,-0.1
					cube([bar_length-0.2,20-0.2,thickness],center = true);
			rotate([0,0,-90+120]) translate([-75+20/2,-arm_position,thickness/2])
				translate([-bar_length/2+10-0.2,-0.2,0])//[0,0,-0.1
					cube([bar_length-0.2,20-0.2,thickness],center = true);
			hull() {
				rotate([0,0,-90]) translate([75-20/2,-arm_position,thickness/2]) 
					translate([20.2,20,0])//[0,0,-0.1
						cube([20,60,thickness],center = true);
				rotate([0,0,-90+120]) translate([-75+20/2,-arm_position,thickness/2])
					translate([-20.2,20,0])//[0,0,-0.1
						cube([20,60,thickness],center = true);
				rotate([0,0,-90+60]) translate([0,-arm_length/3*2+20,thickness/2]) {
					cube([60,20,thickness],center = true);
					translate([0,-12,-thickness/2+0.05])//[0,0,-0.1
						cube([80,0.1,0.1],center = true);
				}
			}
			
			rotate([0,0,-90]) translate([75-20/2+bar_length/2+0.2,-arm_position,thickness-0.1]) {
				translate([10,-10,0])//[0,0,-0.1
					rotate([0,-90,0]) linear_extrude( 2 )
						polygon( points=[[-0.1,-0.1],[-0.1,20+39.1],[7,20+39.1]] );
				translate([-17,-10,0])//[0,0,-0.1
					rotate([0,-90,0]) linear_extrude( 2 )
						polygon( points=[[-0.1,-0.1],[-0.1,41.5],[5,41.1]] );
			}
							
			rotate([0,0,-90+120]) translate([-75+20/2-bar_length/2-0.2+2,-arm_position,thickness-0.1]) {
				translate([-10,-10,0])//[0,0,-0.1
					rotate([0,-90,0]) linear_extrude( 2 )
						polygon( points=[[-0.1,-0.1],[-0.1,20+39.5],[7,20+39.1]] ); ////!!!@!
				translate([17,-10,0])//[0,0,-0.1
					rotate([0,-90,0]) linear_extrude( 2 )
						polygon( points=[[-0.1,-0.1],[-0.1,41.5],[5,41.1]] ); ////!@!!!
			}
					
					
	/*		rotate([0,0,-90]) translate([75-20/2+bar_length-20,-arm_position,thickness]) 
				cylinder(r=m5_diameter,h=1,$fn=32);
			rotate([0,0,-90+120]) translate([-(75-20/2+bar_length-20),-arm_position,thickness]) 
				cylinder(r=m5_diameter,h=1,$fn=32);*/
				
			if( use_fan_port )
				rotate([0,0,-90+60]) translate([0,-arm_length/3*2+30,thickness-0.1]) {
					minkowski() {
						cylinder(r=fan_port_diameter/2-2,h=15.1-2,$fn=48);
						sphere( r=2, center=true,$fn = 48 );
					}
					cylinder(r1=fan_port_diameter/2+5,r2=fan_port_diameter/2,h=4.1-2,$fn=48);
				}
			
			
			rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,-1]) {
				rotate([0,0,-60])
					fsr_mount(false,false,0);
			}
			
			rotate([0,0,-90+60]) translate([0,-bed_dia/2+20,thickness+2.5]) ///!!!!!!
				translate([0,0,0])//[0,0,-0.1
				intersection(){
					minkowski() {
						translate([-27.5,1.5,0]) cube([30,57.5,5],center = true);
					//	translate([0,0,-5]) cube([8,10,7]);
						translate([5,1,-2.5]) sphere( r = 2.5, h = 0.01, $fn = 32,center=true);
					}
					translate([-22,-20,0])
                  cube([35,35,5],center = true);
				}
				
			rotate([0,0,-90+60]) translate([0,-bed_dia/2+20,thickness+2.5])
				translate([0,0,0])//[0,0,-0.1
				intersection(){
					minkowski() {
						translate([17.5,1.5,0]) cube([30,57.5,5],center = true);
					//	translate([0,0,-5]) cube([8,10,7]);
						translate([5,1,-2.5]) sphere( r = 2.5, h = 0.01, $fn = 32,center=true);
					}
					translate([22,-20,0])
                  cube([35,35,5],center = true);
				}
		}
		
		rotate([0,0,-90+60]) translate([0,-arm_length/3*2+70,-0.1]) {
			cylinder( r = 2.6, h = 5.0, $fn = 4.2);
		}
		
		translate([0,0,thickness])
			cylinder(r=bed_dia/2,h=10,$fn=300);
		rotate([0,0,-90]) translate([75-20/2,-arm_position,-thickness/2-0.1]) {
			cylinder(r=m5_diameter/2,h=100,$fn=32);
			translate([bar_length-20,0,0])//[0,0,-0.1
				cylinder(r=m5_diameter/2,h=100,$fn=32);
		}
		rotate([0,0,-90+120]) translate([-75+20/2,-arm_position,-thickness/2-0.1]){
			cylinder(r=m5_diameter/2,h=100,$fn=32);
			translate([-bar_length+20,0,0])//[0,0,-0.1
				cylinder(r=m5_diameter/2,h=100,$fn=32);
		}
		
		if( use_fan_port )
			rotate([0,0,-90+60]) translate([0,-arm_length/3*2+30,-5]) 
				cylinder(r=fan_port_diameter/2-2,h=50.1,$fn=48);
	}

}

module cube_top_bevel(s,sph_r) {
	intersection(){
		cube(s,center=true);
		translate([0,0,sph_r])
			minkowski(){
				cube(s-[2*sph_r,2*sph_r,0],center=true);
				sphere(r=sph_r,center=true,$fn=64);
				
			}
	}
}
module cylinder_top_bevel( cyl_r, cyl_h, sph_r ) {
	intersection(){
		cylinder(r=cyl_r,h=cyl_h, $fn = 64);
		minkowski(){
			cylinder(r=cyl_r-sph_r,h=cyl_h-sph_r,$fn = 64);
			sphere(r=sph_r,center=true,$fn=64);
		}
	}
}

module cylinder_bot_bevel( cyl_r, cyl_h, sph_r ) {
	intersection(){
		cylinder(r=cyl_r,h=cyl_h, $fn = 64);
		translate([0,0,sph_r])
			minkowski(){
				cylinder(r=cyl_r-sph_r,h=cyl_h-sph_r,$fn = 64);
				sphere(r=sph_r,center=true,$fn=64);
			}
	}
}




module hex_bed_fsr_mount_a( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter) {
      support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bar_length = abs(150-40-arm_length)/2 ;
	bed_r = 133; 
   
   
	fsr_cyl_dia = 18 ;
	fsr_pad_dia = 13 ;
	fsr_pad_travel = 5 ;
	base_thickness = 7 ;
	branch_additonal_thickness = 5 ;
	bevel = 2 ;
   
	branch_thickness = base_thickness + branch_additonal_thickness ;
	support_bolt_length = 45 ;
      
   union() {
		difference() {
			union() {
				rotate([0,0,-90+60]) translate([0,-fsr_pos,-(branch_thickness+fsr_pad_travel)+base_thickness/2]) 
					cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness+fsr_pad_travel, (fsr_cyl_dia-fsr_pad_dia)/2 );	

            hull() {
               rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
               rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
               rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
            }
            for( i=[-1,1]){
               hull() {
                  rotate([0,0,-90+(i+1)*60]) translate([-i*(50+10/2+5),-arm_position,0]) //10 for width of block + 5 for insert
                     cube_top_bevel([10,20,base_thickness],bevel);

                  rotate([0,0,-90+60]) translate([-i*-30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                     cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
               }
               rotate([0,0,90-(i+1)*30]) translate([-(50-10/2+20),i*-arm_position,0]) {
                  union() {
                     hull() {
                        cube_top_bevel([20 ,20,base_thickness], bevel);
                        translate([0,0,-3]) rotate([0,90,0]) {
                           cube_top_bevel([base_thickness ,20,20], bevel);
                           translate([-3/2,0,bevel]) cube([base_thickness +3,20,20-bevel*2], center = true);
                        }
                     }
                     union() {
                        for( j=[-1,1] ) {
                           translate([20/2-0.1,10,-j*base_thickness/2-(j+1)*1.5]) rotate([90,0,0])
                              linear_extrude(height = 20) 
                                 polygon([	[3,0],
                                             [0,j*2],
                                             [0,0]]);
                           translate([20/2-0.1,j*(20/2),-(3*2+base_thickness)/2]) 
                              linear_extrude(height = 3+base_thickness) 
                                 polygon([	[3,0],
                                             [0,-j*2],
                                             [0,0]]);
                        }
                     }
                  }
               
               }
            }
			}
      
         for( i=[-1,1]){
            rotate([0,0,90-(i+1)*30]) translate([-(50-10/2+20),i*-arm_position,0]) {
               rotate([0,-90,0]) translate([-2,0,-40]) {
                  translate([0,5.5,0]){
                     cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
                  }
                  translate([0,-5.5,0]) {
                     cylinder(r=m3_diameter/2+0.2,h=500,$fn=32); //screw hole
                  }
                  
                  hull() {
                     translate([0,5.5,50]) {
                        cylinder(r=m3_washer_diameter/2+0.2,h=50,$fn=32);
                     }
                     translate([-5,5.5,50]) {
                        cylinder(r=m3_washer_diameter/2+0.2,h=50,$fn=32);
                     }
                  }
                  hull() {
                     translate([0,-5.5,50]) {
                        cylinder(r=m3_washer_diameter/2+0.2,h=50,$fn=32);
                     }
                     translate([-5,-5.5,50]) {
                        cylinder(r=m3_washer_diameter/2+0.2,h=50,$fn=32);
                     }
                  }
               }
            }
         }
      }
   }
}


module hex_bed_fsr_mount_b( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter) {
      support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bar_length = abs(150-40-arm_length)/2 ;
	bed_r = 133; 
   
   
	fsr_cyl_dia = 18 ;
	fsr_pad_dia = 13 ;
	fsr_pad_travel = 5 ;
	base_thickness = 7 ;
	branch_additonal_thickness = 5 ;
	bevel = 2 ;
   
	branch_thickness = base_thickness + branch_additonal_thickness ;
	support_bolt_length = 45 ;
   
   rotate([0,0,-90]) translate([0,-arm_position,0]) {
      difference() {
         union() {
            cube_top_bevel([110 ,20,base_thickness], bevel);
            
            translate([0,0,-base_thickness/2]) {
               hull() {
                  translate([-25,6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                  translate([25,6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
               }
               hull() {
                  translate([-25,-6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                  translate([25,-6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
               }
               hull() {
                  translate([-25,0,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                  translate([25,0,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
               }
            }
            
            hull() translate([-110/2+40/2,0,-3]) rotate([0,-90,0]) {
               cube_top_bevel([base_thickness ,20,40], bevel);
               translate([0,0,bevel]) cube([base_thickness ,20,40-bevel*2], center = true);
            }
            hull() translate([110/2-40/2,0,-3]) rotate([0,-90,180]) {
               cube_top_bevel([base_thickness ,20,40], bevel);
               translate([0,0,bevel]) cube([base_thickness ,20,40-bevel*2], center = true);
            }
         }
         union() {
            for(j=[-1,1]) {
               for( i=[-1,1] ) rotate([0,0,(j-1)*90]) {
                  translate([(-110/2-0.1),10.1,-i*base_thickness/2-(i+1)*1.5-i*.1]) rotate([90,0,0])
                     linear_extrude(height = 20.2) 
                        polygon([	[3,0],
                                    [0,i*2],
                                    [0,0]]);
                  translate([(-110/2-0.1),i*(20/2+0.1),-(3*2+base_thickness)/2-0.1]) 
                     linear_extrude(height = 3+base_thickness+0.2) 
                        polygon([	[3,0],
                                    [0,-i*2],
                                    [0,0]]);
               }
               rotate([0,0,(j+1)*90]) translate([50-7,0,0]) {
               //screw holes for hex bed connection
                  translate([-86,0,-base_thickness])
                     cylinder(r=m3_diameter/2,h=100,$fn=32);
                  translate([-86,0,-base_thickness/2-0.1]) union(){
                     cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
                     translate([0,0,-10])
                        cylinder(r=m3_nut_diameter/2,h=10.1,$fn=32);
                  }
               // end screw holes for hex bed connection

               //screw holes for circular connection   
                  rotate([0,-90,0]) translate([-2,0,103-30]) {
                     translate([0,5.5,0]){
                        cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
                        translate([0,0,5]) hull() {
                           cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                           translate([-5,0,0]) 
                              cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                        }
                     }
                     translate([0,-5.5,0]) {
                        cylinder(r=m3_diameter/2+0.2,h=500,$fn=32); //screw hole
                        translate([0,0,5]) hull() { //nut trap
                           cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                           translate([-5,0,0]) 
                              cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                        }
                     }
                  }
               }
               // end screw holes for circular connection
            }
         }
      }
   }
   
}

module hex_bed_fsr_mount_a_old( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter) {
   support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bar_length = abs(150-40-arm_length)/2 ;
	bed_r = 133; 
   
   
	fsr_cyl_dia = 18 ;
	fsr_pad_dia = 13 ;
	fsr_pad_travel = 5 ;
	base_thickness = 7 ;
	branch_additonal_thickness = 5 ;
	bevel = 2 ;
   
	branch_thickness = base_thickness + branch_additonal_thickness ;
	support_bolt_length = 45 ;
      
   union() {
		difference() {
			union() {
				rotate([0,0,-90+60]) translate([0,-fsr_pos,-(branch_thickness+fsr_pad_travel)+base_thickness/2]) 
					cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness+fsr_pad_travel, (fsr_cyl_dia-fsr_pad_dia)/2 );	

            hull() {
               rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
               rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
               rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
            }
            
            // long arm side
            hull() {
               rotate([0,0,-90]) translate([50-5+20,-arm_position,0]) 
                  cube_top_bevel([10,20,base_thickness],bevel);

               rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,-branch_thickness+base_thickness/2]) 
                  cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
            }
				rotate([0,0,-90]) translate([5,-arm_position,0]) {
               difference() {
                  union() {
                     cube_top_bevel([130 ,20,base_thickness], bevel);
                     
                     translate([0,0,-base_thickness/2]) {
                        hull() {
                           translate([-25,6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           translate([56,6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                        }
                        hull() {
                           translate([-25,-6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           translate([60,-6,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                        }
                        hull() {
                           translate([-25,0,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           translate([29,0,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                        }
                        hull() {
                           translate([47,0,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           translate([58,0,0]) cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                        }
                        translate([-5,arm_position,0]) rotate([0,0,39]) translate([-30,-bed_dia/2-16,0]) {
                           hull() translate([4,5.5,0]){
                               cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                              translate([30,0,0])
                                 cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           }
                           hull() translate([2,-0.5,0]){
                               cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                              translate([30,0,0])
                                 cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           }
                           hull() translate([0,-6.5,0]){
                              cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                              translate([30,0,0])
                                 cube_top_bevel([4*bevel ,5, base_thickness], bevel);
                           }
                        }
                     }
                     
                     hull() translate([-130/2+40/2,0,-3]) rotate([0,-90,0]) {
                        cube_top_bevel([base_thickness ,20,40], bevel);
                        translate([0,0,bevel]) cube([base_thickness ,20,40-bevel*2], center = true);
                     }
                  }
                  union() {
                     for( i=[-1,1] ) {
                        translate([-130/2-0.1,10.1,-i*base_thickness/2-(i+1)*1.5-i*.1]) rotate([90,0,0])
                           linear_extrude(height = 20.2) 
                              polygon([	[3,0],
                                          [0,i*2],
                                          [0,0]]);
                        translate([-130/2-0.1,i*(20/2+0.1),-(3*2+base_thickness)/2-0.1]) 
                           linear_extrude(height = 3+base_thickness+0.2) 
                              polygon([	[3,0],
                                          [0,-i*2],
                                          [0,0]]);
                     }
                  }
               }
            }
            // end long arm side
            //short arm side
            hull() {
					rotate([0,0,-90+120]) translate([-(50-5+20),-arm_position,0])
						cube_top_bevel([10,20,base_thickness],bevel);
					//	cube([10,20,5],center=true);
						
					rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
				}
            rotate([0,0,-90+120]) translate([-(50-5+15+20/2),-arm_position,0]) {
               union() {
                  hull() {
                     cube_top_bevel([20 ,20,base_thickness], bevel);
                     translate([0,0,-3]) rotate([0,90,0]) {
                        cube_top_bevel([base_thickness ,20,20], bevel);
                        translate([-3/2,0,bevel]) cube([base_thickness +3,20,20-bevel*2], center = true);
                     }
                  }
                  union() {
                     for( i=[-1,1] ) {
                        translate([20/2-0.1,10,-i*base_thickness/2-(i+1)*1.5]) rotate([90,0,0])
                           linear_extrude(height = 20) 
                              polygon([	[3,0],
                                          [0,i*2],
                                          [0,0]]);
                        translate([20/2-0.1,i*(20/2),-(3*2+base_thickness)/2]) 
                           linear_extrude(height = 3+base_thickness) 
                              polygon([	[3,0],
                                          [0,-i*2],
                                          [0,0]]);
                     }
                  }
               }
            }
            // end short arm side	
			}
      
         //long arm side
         rotate([0,0,-90]) translate([50-7,-arm_position,0]) {
            //screw holes for hex bed connection
            translate([0,0,-base_thickness])
               cylinder(r=m3_diameter/2,h=100,$fn=32);
            translate([0,0,-base_thickness/2-0.1])
               cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
            
            translate([-86,0,-base_thickness])
               cylinder(r=m3_diameter/2,h=100,$fn=32);
            translate([-86,0,-base_thickness/2-0.1]) union(){
               cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
               translate([0,0,-10])
                  cylinder(r=m3_nut_diameter/2,h=10.1,$fn=32);
            }
            // end screw holes for hex bed connection
         

            //screw holes for circular connection   
            rotate([0,-90,0]) translate([-2,0,103-30]) {
               translate([0,5.5,0]){
                  cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
                  translate([0,0,5]) hull() {
                     cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                     translate([-5,0,0]) 
                        cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                  }
               }
               translate([0,-5.5,0]) {
                  cylinder(r=m3_diameter/2+0.2,h=500,$fn=32); //screw hole
                  translate([0,0,5]) hull() { //nut trap
                     cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                     translate([-5,0,0]) 
                        cylinder(r=m3_nut_diameter/2+0.2,h=3,$fn=6);
                  }
               }
            }
         }
            // end screw holes for circular connection
         
         //end long arm side
         
         //short arm side
         rotate([0,0,-90+120]) translate([50-7,-arm_position,0]) {
            rotate([0,-90,0]) translate([-2,0,103-30]) {
               translate([0,5.5,0]){
                  cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
               }
               translate([0,-5.5,0]) {
                  cylinder(r=m3_diameter/2+0.2,h=500,$fn=32); //screw hole
               }
               
               hull() {
                  translate([0,5.5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
                  translate([-5,5.5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
               }
               hull() {
                  translate([0,-5.5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
                  translate([-5,-5.5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
               }
            }
         }
         //end short arm side
      }
   }
}

module hex_bed_fsr_mount_b_old( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter) {
  	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bar_length = abs(150-40-arm_length)/2 ;
	bed_r = 133; 
   
   
	fsr_cyl_dia = 18 ;
	fsr_pad_dia = 13 ;
	fsr_pad_travel = 5 ;
	base_thickness = 7 ;
	branch_additonal_thickness = 5 ;
	bevel = 2 ;
   
	branch_thickness = base_thickness + branch_additonal_thickness ;
	support_bolt_length = 45 ;
      
   union() {
		difference() {
			union() {
            //short arm side
            rotate([0,0,-90+120]) translate([-(50-5+15+20/2),-arm_position,0]) {
               union() {
                  hull() {
                     cube_top_bevel([20 ,20,base_thickness], bevel);
                     translate([0,0,-3]) rotate([0,90,0]) {
                        cube_top_bevel([base_thickness ,20,20], bevel);
                        translate([-3/2,0,bevel]) cube([base_thickness +3,20,20-bevel*2], center = true);
                     }
                  }
                  union() {
                     for( i=[-1,1] ) {
                        translate([20/2-0.1,10,-i*base_thickness/2-(i+1)*1.5]) rotate([90,0,0])
                           linear_extrude(height = 20) 
                              polygon([	[3,0],
                                          [0,i*2],
                                          [0,0]]);
                        translate([20/2-0.1,i*(20/2),-(3*2+base_thickness)/2]) 
                           linear_extrude(height = 3+base_thickness) 
                              polygon([	[3,0],
                                          [0,-i*2],
                                          [0,0]]);
                     }
                  }
               }
            }
            // end short arm side
            					
				rotate([0,0,-90+60]) translate([0,-fsr_pos,-(branch_thickness+fsr_pad_travel)+base_thickness/2]) 
					cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness+fsr_pad_travel, (fsr_cyl_dia-fsr_pad_dia)/2 );
					
					
				intersection() {
               union() {
                  hull() {
                     rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,base_thickness/2-branch_thickness-0.1])
                        cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness,bevel );
                     
                     rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                        cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness,bevel );
                  }
                  hull() {
                     rotate([0,0,-90]) translate([50-5+20,-arm_position,0]) 
                        cube_top_bevel([10,20,base_thickness],bevel);

                     rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,-branch_thickness+base_thickness/2]) 
                        cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
                  }
               }
               union() {
                  rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,-branch_thickness+base_thickness-0.5]) rotate([0,0,-20]) {
                     cube( [25,10-0.2,base_thickness-0.2],center = true );
                     difference() {
                        translate([-25/2,0,0]) hull() {
                          translate([0,0,-base_thickness/4]) cube( [10,5-0.2,base_thickness/2],center = true );
                           cube( [0.01,0.01,base_thickness-0.1],center = true );
                        }
                        cube( [25-0.1,10-0.1,base_thickness*4],center = true );
                     }
                  }
               }
            }
						
				hull() {
					rotate([0,0,-90+120]) translate([-(50-5+20),-arm_position,0])
						cube_top_bevel([10,20,base_thickness],bevel);
					//	cube([10,20,5],center=true);
						
					rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
				}
				difference() {
               hull() {
                  rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                     cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
                  rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                     cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
                  rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
                     cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
               }
               
              // hull() 
         #            rotate([0,0,-90+60]) translate([-35,-bed_dia/2-16,base_thickness/2-branch_thickness/2])
                        cube([20+0.2,20,branch_thickness+0.1],center=true);
               
				}
			}
         
         //short arm side
         rotate([0,0,-90+120]) translate([50-7,-arm_position,0]) {
            rotate([0,-90,0]) translate([-2,0,103-30]) {
               translate([0,5,0]){
                  cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
               }
               translate([0,-5,0]) {
                  cylinder(r=m3_diameter/2+0.2,h=500,$fn=32); //screw hole
               }
               
               hull() {
                  translate([0,5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
                  translate([-5,5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
               }
               hull() {
                  translate([0,-5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
                  translate([-5,-5,50]) {
                     cylinder(r=m3_washer_diameter/2,h=50,$fn=32);
                  }
               }
            }
         }
         //end short arm side
         //screw holes for side connectors
         rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,-branch_thickness+base_thickness/2-1]) rotate([0,0,-20]) {
            translate([1,0,0]) cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
            translate([-7,0,0]) cylinder(r=m3_diameter/2+0.2,h=500,$fn=32);
            
            
            translate([1,0,1-0.1]) rotate([0,0,10]) cylinder(r=m3_nut_diameter/2+0.2,h=2.6,$fn=6);
            translate([-7,0,1-0.1]) rotate([0,0,10]) cylinder(r=m3_nut_diameter/2+0.2,h=2.6,$fn=6);
         }
         // end screw holes for side connectors
      }
   }
   
}

module hex_bed_fsr_mount(assembled, bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter) {
   if( assembled == true ) {
      hex_bed_fsr_mount_a( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
      hex_bed_fsr_mount_b( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
   } else {
            
      rotate([180,0,0])
      {
         translate([ -60, -60,0]) 
            hex_bed_fsr_mount_a( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
      
         translate([-20,-20,0]) 
            hex_bed_fsr_mount_b( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
      }
   }
}

module hex_bed_fsr_mount_old2(assembled, bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter) {
   if( assembled == true ) {
      hex_bed_fsr_mount_a_old( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
   } else {
            
      rotate([180,0,0])
      {
      translate([ 10, 10,0]) 
      rotate([0,0,60]) xFemaleCut(kerf = -0.2, offset = 20, cut = [-141]) union() {
         difference() {
            rotate([0,0,-60]) hex_bed_fsr_mount_a_old( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
            translate([-141,20+5.8,-2]) rotate([0,90,0]) cylinder(r=m3_diameter/2+0.2,h = 50, center = true); 
            translate([-141-9,20+5.8,-2]) rotate([0,90,0]) cylinder(r=m3_nut_diameter/2+0.2,h = 2,$fn=6); 
         }
      //   cube([500,500,1],center=true);
      }
      translate([-10,-10,0])
      rotate([0,0,60]) xMaleCut(kerf = -0.2, offset = 20, cut = [-141]) union() {
         difference(){
            rotate([0,0,-60]) hex_bed_fsr_mount_a_old( bed_dia,arm_position,arm_length,fsr_pos,use_fan_port,fan_port_diameter);
            translate([-141,20+5.8,-2]) rotate([0,90,0]) cylinder(r=m3_diameter/2+0.2,h = 50, center = true); 
         }
         //cube([500,500,1],center=true);
      }
      }
   }
}

module hex_bed_fsr_mount_old(bed_dia,arm_position,arm_length,use_fan_port,fan_port_diameter) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	
	bar_length = abs(150-40-arm_length)/2 ;
	bed_r = 133;
	
	fsr_cyl_dia = 18 ;
	fsr_pad_dia = 13 ;
	fsr_pad_travel = 5 ;
	base_thickness = 7 ;
	branch_additonal_thickness = 5 ;
	bevel = 2 ;
	use_support_bolt = false ;
	branch_thickness = base_thickness + branch_additonal_thickness ;
	support_bolt_length = 45 ;

	union() {
		difference() {
			union() {
				rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,0])
					cube_top_bevel([40,20,base_thickness],bevel);
				rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,0]) 
					cube_top_bevel([40,20,base_thickness],bevel);
				//	cube([40,20,5],center=true);
					
				rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,-(branch_thickness+fsr_pad_travel)+base_thickness/2]) 
					cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness+fsr_pad_travel, (fsr_cyl_dia-fsr_pad_dia)/2 );
			//		cylinder( r=18/2, h = 10+5 );
					
					
				hull() {
				
					rotate([0,0,-90]) translate([50-5-m3_diameter/2+20,-arm_position,0]) 
						cube_top_bevel([10,20,base_thickness],bevel);

						
					rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,-branch_thickness+base_thickness/2]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
				}
						
				hull() {
					rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2+20),-arm_position,0])
						cube_top_bevel([10,20,base_thickness],bevel);
					//	cube([10,20,5],center=true);
						
					rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
				}
				hull() {
					rotate([0,0,-90+60]) translate([-30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
					rotate([0,0,-90+60]) translate([30,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
					rotate([0,0,-90+60]) translate([0,-bed_dia/2-16,base_thickness/2-branch_thickness]) 
						cylinder_bot_bevel( fsr_cyl_dia/2, branch_thickness, bevel );
				}
			}
			union() { // union 55
				rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,3.5]) scale([1,1,1.1]) {
					translate([19+-2.5,2,-2.5]) rotate([45,0,36.5]) translate([4,0,0])cube([48,2.5,2.5]);
					translate([19+2.5,-2,-2.5]) rotate([45,0,37]) translate([4,0,0])cube([51,2.5,2.5]);
				}
				
				rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,-base_thickness/2]) 
					if( use_support_bolt == false ) difference() {
						union()  scale([1,1,1.1]) {
							rotate([45,0,0]) cube([40,2.5,2.5], center=true);
							translate([-2.5,5,0]) rotate([45,0,0]) cube([40,2.5,2.5], center=true);
							translate([0,-5,0]) rotate([45,0,0]) cube([45,2.5,2.5], center=true);
						}
						
						rotate([0,0,-90]) translate([0,0,-2.6])
							cylinder(r=m3_nut_diameter,h=12.5,$fn=6);
					}
				rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,-base_thickness/2]) scale([1,1,1.1]) {
					translate([19,0,-2.5]) rotate([45,5,37]) cube([47.5,2.5,2.5]);
					translate([19+-2.5,5,-2.5]) rotate([45,5,36]) cube([45,2.5,2.5]);
					translate([19+2.5,-5,-2.5]) rotate([45,5,37]) cube([50,2.5,2.5]);
				}

				
				
				
				rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,base_thickness/2+1]) scale([1,1,1.1]) {
					translate([-19+2.5,2,-2.5]) rotate([45,0,180-36.5]) translate([4,0,0])cube([48,2.5,2.5]);
					translate([-19+-2.5,-2,-2.5]) rotate([45,0,180-37]) translate([4,0,0])cube([51,2.5,2.5]);
				}
				
				rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,-base_thickness/2])
					if( use_support_bolt == false ) difference() {
						union() scale([1,1,1.1]) {
							rotate([45,0,0]) cube([40,2.5,2.5], center=true);
							translate([2.5,5,0]) rotate([45,0,0]) cube([40,2.5,2.5], center=true);
							translate([0,-5,0]) rotate([45,0,0]) cube([45,2.5,2.5], center=true);
						}
						rotate([0,0,-90]) translate([0,0,-2.6])
							cylinder(r=m3_nut_diameter,h=12.5,$fn=6);
					}
				rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,-base_thickness/2]) scale([1,1,1.1]) {
					translate([-19,0,-2.5]) rotate([45,5,180-37]) cube([47.5,2.5,2.5]);
					translate([-19+2.5,5,-2.5]) rotate([45,5,180-36]) cube([45,2.5,2.5]);
					translate([-19-2.5,-5,-2.5]) rotate([45,5,180-37]) cube([50,2.5,2.5]);
				}
					
				rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,0]) {
					translate([0,0,-base_thickness])
						cylinder(r=m3_diameter/2,h=100,$fn=32);
					rotate([0,0,0]) translate([0,0,-base_thickness/2-0.1])
						cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
					if( use_support_bolt == true ) {
						rotate([0,90,0]) translate([0,0,-20.1]) {
							translate([0,5,0])
								cylinder(r=m3_diameter/2+0.2,h=support_bolt_length,$fn=32);
							translate([0,-5,0])
								cylinder(r=m3_diameter/2+0.2,h=support_bolt_length,$fn=32);
						}
					}
				}
			
				rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,0]) {
					translate([0,0,-base_thickness])
						cylinder(r=m3_diameter/2,h=100,$fn=32);
					rotate([0,0,0]) translate([0,0,-base_thickness/2-0.1])
						cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
					if( use_support_bolt == true ) {
						rotate([0,-90,0]) translate([0,0,-20.1]) {
							translate([0,5,0])
								cylinder(r=m3_diameter/2+0.2,h=support_bolt_length,$fn=32);
							translate([0,-5,0])
								cylinder(r=m3_diameter/2+0.2,h=support_bolt_length,$fn=32);
						}
					}
				}
			} //union 55
		} //difference
		
		if( use_support_bolt == true ) {
			difference() {
				union() {
					rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,0]) {
						rotate([0,90,0]) translate([0,0,-20]) {
							translate([0,5,0]) difference() {
								cylinder_top_bevel(min(base_thickness/2,m3_diameter),support_bolt_length+5,bevel);
								translate([0,0,-0.1]) cylinder(r=m3_diameter/2+0.1,h=support_bolt_length,$fn=32);
							}
							translate([0,-5,0]) difference() {
								cylinder_top_bevel(min(base_thickness/2,m3_diameter),support_bolt_length+5,bevel);
								translate([0,0,-0.1]) cylinder(r=m3_diameter/2+0.1,h=support_bolt_length,$fn=32);
							}
						}
					}

					rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,0]) {
						rotate([0,-90,0]) translate([0,0,-20]) {
							translate([0,5,0]) difference() {
								cylinder_top_bevel(min(base_thickness/2,m3_diameter),support_bolt_length+5,bevel);
								translate([0,0,-0.1]) cylinder(r=m3_diameter/2+0.1,h=support_bolt_length,$fn=32);
							}
							translate([0,-5,0]) difference() {
								cylinder_top_bevel(min(base_thickness/2,m3_diameter),support_bolt_length+5,bevel);
								translate([0,0,-0.1]) cylinder(r=m3_diameter/2+0.1,h=support_bolt_length,$fn=32);
							}
						}
					}
				}
				union() {
					rotate([0,0,-90]) translate([50-5-m3_diameter/2,-arm_position,0]) 
						translate([0,0,-base_thickness/2-0.1])
							cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
				
			
					rotate([0,0,-90+120]) translate([-(50-5-m3_diameter/2),-arm_position,0]) 
						translate([0,0,-base_thickness/2-0.1])
							cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
				}
			}//differenece
		}
	}
}


function make_left_angle(arm_pos, offset, h ) = atan2(arm_pos+(sin(30)*h),offset-(cos(30)*h));
function make_right_angle(arm_pos, offset, h ) = atan2(arm_pos+(sin(30)*h),offset+(cos(30)*h));

module bed_support_guard(bed_dia,arm_position,arm_length,withFan = false) {
	support_outer_radius = bed_dia/2+6 ;
	support_inner_radius = bed_dia/3 ;
	arm_position_to_end = arm_position+20/2 ;
	arm_position_to_block = arm_length *cos(60);
	endstop_ribbon_hole = 2 ;
	bed_heater_hole = 2.5 ;
	overlap = 6 ;
	h_offset = (overlap/2)/sin(30)*sin(60);
	//h_dist = sqrt(pow(overlap/2,2)*2)/1.22;
	h_dist = (overlap/2)/sin(60);
	left_offset = (22/2+4)+overlap/2 ;
	left_angle = make_left_angle(arm_position_to_end,left_offset,h_dist);
	
	right_offset = (22/2+4)-overlap/2 ;
	right_angle =  make_right_angle(arm_position_to_end,right_offset,h_dist);
	union() {
	translate([cos(30)*(quadralateral_offset),sin(30)*(-quadralateral_offset),0]) fsr_mount(false,true);
	difference() {
		union() {
			rotate([0,0,-30]) intersection() {
				translate([arm_position,0,0]) cylinder(r=22/2+4, h = 5);
				
				
				hull() translate([arm_position_to_end-20,0, 0])  {
					translate([19.9,-left_offset,0]) cube([40.1,1,5]);
					translate([0,arm_length/2-30,0]) cube([20,20,5]);
				}
			}
		//	hull()	translate([0,0,1]) rotate([0,0,-36]){
		//			cylinder(r=0.1, h=5,$fn=16);//cube([0.1,0.1,5]);
		//		translate([cos(30)*h_offset,sin(30)*h_offset,0])
		//			cylinder(r=0.1, h=5,$fn=16);//cube([0.1,0.1,5]);
		//		translate([cos(150)*h_offset,sin(150)*h_offset,0])
		//			cylinder(r=0.1, h=5,$fn=16);//cube([0.1,0.1,5]);
		//}
	//			translate([-cos(30)*h_offset,-sin(30)*h_offset,-4])
	//	#		cylinder(r=max(h_offset/2,0.1), h=5,$fn=16);//cube([0.1,0.1,5]);
	//			translate([-cos(30)*h_dist,-sin(30)*h_dist,14])
	//	#		cylinder(r=0.1, h=5,$fn=16);//cube([0.1,0.1,5]);
		//bottom plate
			hull() {
				//rotate([0,0,30]) 
				translate([-cos(30)*h_dist,-sin(30)*h_dist,0])
					cube([0.1,0.1,5]);
				rotate([0,0,-30]) translate([arm_position_to_end-20,0, 0])  {
					translate([19.9,-left_offset,0]) cube([0.1,1,5]);
					translate([0,arm_length/2-30,0]) cube([20,20,5]);
				}
				rotate([0,0, 90]) translate([arm_position+20/2-20,0, 0]){
					translate([19.9,-right_offset-20.0,0]) cube([0.1,20,5]);
					translate([0,-(arm_length/2)+10,0]) cube([20,20,5]);
				}
			}
			rotate([0,0,-30]) translate([arm_position+20/2-20,0, 0]) 
				translate([0,arm_length/2-20,0]) cube([20,20,5]);
			rotate([0,0, 90]) translate([arm_position+20/2-20,0, 0])
				translate([0,-(arm_length/2),0]) cube([20,20,5]);
		//end bottom plate
		rotate([0,0,-30]) {
				translate([arm_position,arm_length/2-20,5]) difference() {
					cylinder(r=m5_washer_diameter/2+2, h = 1);
					cylinder(r=m5_washer_diameter/2, h = 1.2);
				}
		//screw caps left taken car of in the fsr_mount module
			/*	translate([arm_position,20,5]) difference() {
					cylinder(r=m5_washer_diameter/2+2, h = 1);
					cylinder(r=m5_washer_diameter/2, h = 1.2);
				}*/
			}
		//screw caps right
			rotate([0,0,90]) {
				translate([arm_position,-arm_length/2+20,5]) difference() {
					cylinder(r=m5_washer_diameter/2+2, h = 1);
					cylinder(r=m5_washer_diameter/2, h = 1.2);
				}
				translate([arm_position,-20-overlap,5]) difference() {
					cylinder(r=m5_washer_diameter/2+2, h = 1);
					cylinder(r=m5_washer_diameter/2, h = 1.2);
				}
			}
			if( withFan == true )
			rotate([0,0,-60]) translate([-30,arm_position_to_block-20,0]) {
				//translate([0,10,40]) rotate([-40,0,0]) _fan_mount( 60, 50, 4.4, 4);
				hull() {
					_fan_outline( 60, 50, 4.4, 4);
					translate([0,10,40]) rotate([-40,0,0]) _fan_outline( 60, 50, 4.4, 4);
				}
			}
		}
		//bed power wires hole
		cylinder( r = bed_heater_hole, h = 5.2, $fn = 15);
		
		//down slant cutout on the left side
		rotate([0,0,-30]) translate([arm_position_to_end-20,0, 0]) 
			translate([20.0,-left_offset,0]) rotate([0,0,left_angle]) rotate([90,0,180]) translate([0,0,-overlap/2]) 
				//translate([-overlap/2,0,(arm_position_to_end+20+overlap)/2]) #cube([max(overlap,0.1),2,arm_position_to_end+20+overlap],center=true);
				linear_extrude( arm_position_to_end+20+overlap ) polygon( points=[[0.1,-0.1],[-overlap-0.1,5.1],[0.1,5.1]] );
		//up slant cutout on the right side
		rotate([0,0,90]) translate([arm_position_to_end-20,0, 0]) 
			translate([20.0,-right_offset,0]) rotate([0,0,right_angle]) rotate([90,0,180]) translate([0,0,-overlap/2]) 
				//translate([overlap/2,0,(arm_position_to_end+20+overlap)/2]) #cube([max(overlap,0.1),2,arm_position_to_end+20+overlap],center=true);
				linear_extrude( arm_position_to_end+20+overlap ) polygon( points=[[-0.1,-0.1],[overlap+0.1,-0.1],[-0.1,5.1]] );
		
		
		//holes
		rotate([0,0,-30]) {
			translate([arm_position,arm_length/2-20,-0.1]) cylinder(r=m5_diameter/2, h = 6.2, $fn = 12);
			translate([arm_position,20,-0.1]) cylinder(r=m5_diameter/2, h = 6.2, $fn = 12);
		}
		
		rotate([0,0,90]) {
			translate([arm_position,-arm_length/2+20,-0.1]) cylinder(r=m5_diameter/2, h = 6.2, $fn = 12);
			translate([arm_position,-20-overlap,-0.1]) cylinder(r=m5_diameter/2, h = 6.2, $fn = 12);
		}
		//hole for the fsr ribbon
		rotate([0,0,-30]) translate([arm_position,0,0])
			rotate([0,0,180]) translate([16,-5,-0.1]) cube([1.5,10,6.2]);
			
			
		if( withFan == true ){
			rotate([0,0,-60]) translate([-30,arm_position_to_block-20,0]) union() {
				hull() {
					translate([0,0,-10]) _fan_cutout( 60, 50, 4.4, 4);
					translate([0,10,40]) rotate([-40,0,0]) translate([0,0,0]) _fan_cutout( 60, 50, 4.4, 4);
				}
				hull() {
					translate([0,10,40]) rotate([-40,0,0]) translate([0,0,0]) _fan_cutout( 60, 50, 4.4, 4);
					translate([0,10,40]) rotate([-40,0,0]) translate([0,0,10]) _fan_cutout( 60, 50, 4.4, 4);
				}
			}
			rotate([0,0,-60]) translate([-30,arm_position_to_block-20,0]) 
				cylinder( r = 2,h = 6 );
		}
		rotate([0,0,-60]) translate([22,arm_position_to_block+35,-2]) hull() {
			cylinder( r = endstop_ribbon_hole, h = 10);
			translate([0,20,0]) cylinder( r = endstop_ribbon_hole, h = 10);
		}
	}
	
	if( withFan == true ) 
		rotate([0,0,-60]) translate([-30,arm_position_to_block-20,0]) 
			translate([0,10,40]) rotate([-40,0,0]) _fan_mount( 60, 50, 4.4, 4);
	
	}
}

cork_size = 250 ;
bed_size = 260 ;
arm_size = 300 ;
show_frame = false ;
show_bed = false ;
show_bed_clips = true ; 
show_bottom_frame = false ;
show_bottom_frame2 = false ;
show_support_fsr = false ;
show_motor = false;
show_support_guard = false ;
show_fsr_mount = false ;
show_cork = false ;
show_hex_bed = false ;
show_hex_bed_side_mount = false ;
show_hex_bed_corner_mount = false ;
show_hex_bed_fsr_mount = false ;
show_elecs = false ;

use_fan_exhaust = true ;
fan_exhaust_diameter = 19 ;

bottom_frame_size = 74 ;
positions = [30];//,150,270];

offset = 0.0 ;

//SQRT(POWER(C6,2)+POWER(C6/2,2))/2
//arm_size+(2*bottom_frame_size)
//sqrt(pow(arm_size+(2*bottom_frame_size),2)+pow(arm_size+(2*bottom_frame_size)/2,2))/2

quadralateral_arm_len = arm_size+(2*bottom_frame_size);
quadralateral_offset = sqrt(pow(quadralateral_arm_len,2)-pow(quadralateral_arm_len/2,2))/3 ;
bottom_quadralateral_offset = sqrt(pow(quadralateral_offset,2)+pow(quadralateral_arm_len/2,2)) ;
fsr_radial_position = cork_size/2+16;

if( show_bed )
	translate([0,0,13])	color("Blue",0.1) cylinder(r=bed_size/2, h = 3 );
	
if( show_support_fsr )
	for( i = positions )
		rotate([0,0,i-150])
			bed_support_fsr(bed_size,quadralateral_offset);
if( show_support_guard )
	for( i = positions ) 
		rotate([0,0,i-150])
			translate([cos(30)*offset,sin(30)*offset,-15]) bed_support_guard(bed_size,quadralateral_offset,arm_size);
//translate([0,0,-5]) bed_support_brace(bed_size);
else if( show_fsr_mount )
	for( i = positions ) 
		rotate([0,0,i-150])
			translate([cos(30)*(offset+quadralateral_offset),sin(30)*(offset-quadralateral_offset),-15]) fsr_mount(true,true);
	
if( show_hex_bed )
	translate([0,0,10]) color("Blue") hex_bed(bed_size,quadralateral_offset,arm_size);
if( show_cork )
	translate([0,0,-10]) color("Brown") cylinder(r=cork_size/2,h=10);
      
if( show_bed_clips )
	for( i = positions )
		rotate([0,0,i-30])
         translate([0,0,6]) hex_bed_clip(bed_size,quadralateral_offset,arm_size);
   
if( show_hex_bed_side_mount )
	for( i = positions )
		rotate([0,0,i])
			translate([0,0,-15]) hex_bed_side_mount(cork_size,quadralateral_offset,arm_size);
			
if( show_hex_bed_corner_mount )
	for( i = positions )
		rotate([0,0,i])
			translate([0,0,-20]) hex_bed_corner_mount(cork_size,quadralateral_offset,arm_size,use_fan_exhaust,fan_exhaust_diameter);
			
if( show_hex_bed_fsr_mount )
	for( i = positions )
		rotate([0,0,i])
			translate([0,0,1]) hex_bed_fsr_mount(len(positions)>1,cork_size,quadralateral_offset,arm_size,fsr_radial_position);
	
if( show_frame )
	for( i = positions )
		rotate([0,0,i])
			translate([-quadralateral_offset,0,-30]) color("Black") cube([20,arm_size+37,20], center=true);
//2+21
a = [0,0,-30];
if( show_bottom_frame )
	for( i = positions )
		rotate([0,0,i])
			translate([-10,5,-70]) 
				rotate(a) translate([0,-(bottom_quadralateral_offset),0]) rotate(-a) 
					color("Red") import("Kossel_Rav_Alt_bottom_frame_20mm_V3(centered).stl");

a = [0,0,-30];
if( show_bottom_frame2 )
	for( i = positions )
		rotate([0,0,i])
			translate([41.5,-24.5,-80]) 
				rotate(a) translate([0,-(bottom_quadralateral_offset),0]) rotate(-a) rotate([0,0,60])
					color("Red") import("LowerFrameBracket.stl");
   
a = [0,0,-30];
if( show_motor )
	for( i = positions )
		rotate([0,0,i-30])
			translate([108,73,-66]) 
				rotate(a) translate([0,-(bottom_quadralateral_offset),0]) rotate(-a) rotate([90,0,0])
					color("Silver") import("nema17.stl");

include <K250-electronic-mount.scad>


if( show_elecs ){
	//for( i = positions )
		//rotate([0,0,-positions[0]])
			translate([0,-120,-67.5]) 
				main_thing_puzzle ();
				
		//	translate([0,-0,-67.5]) 
		//		main_thing();
}
				
				
				