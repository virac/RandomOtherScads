
use<parametric_involute_gear_v5.0.scad>

module double_helix_gear (
	teeth=13,
	circles=8,
	h=20,
	hub_t = 10,
	hub_d = 15,
	bore_d = 5)
{
	//double helical gear
	{
		twist=200;
	//	height=20;
		pressure_angle=30;

		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = h/2,
			rim_thickness = h/2,
			rim_width = 5,
			hub_thickness = hub_t,
			hub_diameter=hub_d,
			bore_diameter=bore_d,
			circles=circles,
			twist=twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = h/2,
			rim_thickness = h/2,
			rim_width = 5,
			hub_thickness = h/2,
			hub_diameter=15,
			bore_diameter=bore_d,
			circles=circles,
			twist=twist/teeth);
	}
}
use_min = false;
step = 0.05 ;
fil_rad = 1.75/2 ;

big_res = 24 ; 
big_teeth = 48 ;

sm_res = 24 ; 
sm_teeth = 10 ;
sm_count = 12 ;
sm_count_invs = 0 ;

clearance = 0.2 ;
circular_pitch=700;

	big_pitch_diameter  =  big_teeth * circular_pitch / 180;
	big_pitch_radius = big_pitch_diameter/2;
	big_pitch_diametrial = big_teeth /big_pitch_diameter;
	big_addendum = 1/big_pitch_diametrial;
	big_dedendum = big_addendum + clearance;
	big_outer_radius = big_pitch_radius+big_addendum;
	big_root_radius = big_pitch_radius-big_dedendum;
	
	
	
	
	sm_pitch_diameter  =  sm_teeth * circular_pitch / 180;
	sm_pitch_radius = sm_pitch_diameter/2;
	sm_pitch_diametrial = sm_teeth /sm_pitch_diameter;
	sm_addendum = 1/sm_pitch_diametrial;
	sm_dedendum = sm_addendum + clearance;
	sm_outer_radius = sm_pitch_radius+sm_addendum;
	sm_root_radius = sm_pitch_radius-sm_dedendum;
/*	
difference() {
	double_helix_gear(big_teeth,6,10);
	if( use_min ) {
		translate([0,0,-0.05])	//minkowski() { 
			union() {
				difference() {
					cylinder(r=outer_radius+2,h=0.01);
					translate([0,0,-0.05])
						cylinder(r=outer_radius-(outer_radius-root_radius)/2-0.01,h=0.1,$fn=128);
				}
				//hull() {
					difference() {
						cylinder(r=outer_radius+2,h=0.5);
						translate([0,0,-0.5])
							cylinder(r=outer_radius,h=2,$fn=128);
					}
					difference() {
						cylinder(r=outer_radius+2,h=0.01);
						translate([0,0,-0.05])
							cylinder(r=outer_radius-(outer_radius-root_radius)*1/4-0.01,h=0.1,$fn=128);
					}
				
			}
			//sphere(r=1.75/2,$fn=16);
		
	} else {
		difference() {
			translate([0,0,-1.75/2])
				cylinder(r=big_outer_radius+20,h=1.75);
			union() {
				for( i=[-fil_rad-step : step : fil_rad+2*step ] ) {
			//	echo("i=",i," fil_rad=",fil_rad," res=",i/fil_rad," acos=",acos(i/fil_rad));
			//	echo("i=",i," rad=",rad_calc(i,fil_rad));
					hull() 
					{
						if( i > -fil_rad ) {
							translate([0,0,i-step+neg_stat_thing( i-step, step )])
								cylinder(r=big_root_radius+rad_calc(i-step,fil_rad),h=step,$fn=big_res);
						}
						translate([0,0,i+neg_stat_thing( i, step )])
							cylinder(r=big_root_radius+rad_calc(i,fil_rad),h=step,$fn=big_res,center=true);
						if( i < fil_rad ) {
							translate([0,0,i+step+neg_stat_thing( i+step, step )])
								cylinder(r=big_root_radius+rad_calc(i+step,fil_rad),h=step,$fn=big_res);
						}
					}
					//=SIN(ACOS($A2/$A$1))*$A$1
				}
			}
		}
	}
}*/

//for( j = [1:sm_count-sm_count_invs] ) rotate([0,0,j/sm_count * (360-30)]) translate([sm_pitch_radius+big_pitch_radius,0,0]) 
	difference() {
		union() {
			double_helix_gear(sm_teeth,0,10,1,0,16);
			difference() {
				translate([0,0,-2])
					cylinder(r=8,h=4);
				translate([0,0,-3])
					cylinder(r=5,h=6);
			}
		}
		difference() {
			translate([0,0,-1.75/2])
				cylinder(r=sm_outer_radius+20,h=1.75);
			union() {
				for( i=[-fil_rad-step : step : fil_rad+2*step ] ) {
			//	echo("i=",i," fil_rad=",fil_rad," res=",i/fil_rad," acos=",acos(i/fil_rad));
			//	echo("i=",i," rad=",rad_calc(i,fil_rad));
					hull() 
					{
						if( i > -fil_rad ) {
							translate([0,0,i-step+neg_stat_thing( i-step, step )])
								cylinder(r=sm_outer_radius-fil_rad*2+rad_calc(i-step,fil_rad),h=step,$fn=big_res);
						}
						translate([0,0,i+neg_stat_thing( i, step )])
							cylinder(r=sm_outer_radius-fil_rad*2+rad_calc(i,fil_rad),h=step,$fn=big_res,center=true);
						if( i < fil_rad ) {
							translate([0,0,i+step+neg_stat_thing( i+step, step )])
								cylinder(r=sm_outer_radius-fil_rad*2+rad_calc(i+step,fil_rad),h=step,$fn=big_res);
						}
					}
					//=SIN(ACOS($A2/$A$1))*$A$1
				}
			}
		}
	}
function neg_stat_thing( sig, val )  = (sig<0) ? -val : 0 ;
function rad_calc( rad, scal ) = (rad>=scal) ? scal : 
									(rad<=-scal) ? scal : 	scal-(sin(acos(rad/scal))*scal);//  (acos(rad/scal)=="NaN") ? scal : 
