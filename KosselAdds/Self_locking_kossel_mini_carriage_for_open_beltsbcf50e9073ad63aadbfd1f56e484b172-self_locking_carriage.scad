//include <configuration.scad>;
kerf = 0.15;
belt_lock = false;
tensioner_short = false;
// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 6;


pulley_16T_D = 9.68;

belt_width = 5;
belt_thick = 1.38;
belt_pitch_thick = 0.75;
belt_x = pulley_16T_D/2+belt_thick-belt_pitch_thick;
belt_z = 7;
t_corner_radius = 3.5;


horn_thickness = 13;
horn_x = belt_x+2;
horn_y_offset = 0;

m3_nut_radius = 3.0;
m3_wide_radius = 1.5;

carriage_width = 27;
carriage_height = 40;

belt_lock_arm = carriage_width /2-belt_x;
tensioner_half_width = belt_x;
tensioner_grip = 2;
corner_radius = min(t_corner_radius, (pulley_16T_D-belt_thick)/2*0.8);

belt_tensioner_brace = belt_x-(belt_thick+belt_pitch_thick)*.95-corner_radius;

module carriage() {
// Timing belt (up and down).
   translate([0,40,0]) %
      cylinder(r = pulley_16T_D/2,h = 20,$fn=32);
   translate([0,-40,0]) %
      cylinder(r = pulley_16T_D/2,h = 20,$fn=32);
   translate([-belt_x+belt_thick/2, 0, belt_z + belt_width/2]) %
      cube([belt_thick, 100, belt_width], center=true);
   translate([-belt_x+(belt_thick-belt_pitch_thick/2), 0, belt_z + belt_width/2]) %
      cube([belt_pitch_thick, 100, belt_width], center=true);
   translate([belt_x-belt_thick/2, 0, belt_z + belt_width/2]) %
      cube([belt_thick, 100, belt_width], center=true);
   translate([belt_x-(belt_thick-belt_pitch_thick/2), 0, belt_z + belt_width/2]) %
      cube([belt_pitch_thick, 100, belt_width], center=true);


   difference() {
      union() {
         // Main body.
         translate([0, 4, thickness/2])
            cube([carriage_width, carriage_height, thickness], center=true);
         
         // Ball joint mount horns.
         for (x = [-1, 1]) {
            scale([x, 1, 1]) intersection() {
               translate([0, horn_y_offset+4, horn_thickness/2])
                  cube([separation, 18, horn_thickness], center=true);
               translate([horn_x, horn_y_offset+4, horn_thickness/2]) rotate([0, 90, 0])
                  cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
            }
         }

         // Avoid touching diagonal push rods (carbon tube).
         difference() {
            translate([belt_x+belt_lock_arm/2, 4, horn_thickness/2+1])
               cube([belt_lock_arm, 40, horn_thickness-2], center=true);
            translate([23, -8-12, 12.5]) rotate([30, 40, 30])
               cube([40, 40, 20], center=true);
            translate([10, -10, 0])
               cylinder(r=m3_wide_radius+1.5, h=100, center=true, $fn=12);

         }
         // Belt clamps
         // #  for (y = [[9, -1]]) {
         translate([0, 9, horn_thickness/2+1])
            color("green") hull() {
               translate([ belt_x-belt_thick-0.5,  corner_radius-1, 0]) 
                  cube([1.0, 5, horn_thickness-2], center=true);
               cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
            }
         //   }
         //    for (y = [[19, -1]]) {
         translate([belt_tensioner_brace, 19, horn_thickness/2+1])
            rotate([0, 0, 180]) color("blue") hull() {
               translate([ corner_radius-0.5,  1 * corner_radius + -1, 0]) 
                  cube([1.0, 5, horn_thickness-2], center=true);
               cylinder(h=horn_thickness-2, r=corner_radius, $fn=22, center=true);
               translate([ 0,  -4, 0]) 
                  cube([2*corner_radius, 0.5*corner_radius, horn_thickness-2], center=true);
            }
         //  }

   
         //!!!!!!!!add screw hole for belt tensioner
      //   translate([belt_x-3.5,10.8,m3_wide_radius*2+horn_thickness])
         // difference() {
      //      hull() {
      //         cube([m3_wide_radius*2.8,3.8,m3_wide_radius*4],center=true);
         //      translate([0,2.8,-m3_wide_radius*3/2])
         //         cube([m3_wide_radius*2.8,0.1,0.1],center=true);

     //          cube([m3_wide_radius*4,3.8,m3_wide_radius*2],center=true);
      //      }
//
      //  cube([m3_wide_radius*4,4,m3_wide_radius*2],center=true);
         //    translate([0,3,0])
         //       cube([m3_wide_radius*2,3,m3_wide_radius*3],center=true);
         //   }

      }
      //1/8in magnet  placement
      rotate([90,0,0]) translate([0,3,-(24+1)]) cylinder(r=3.175/2,h=3.175+1,$fn=26);//1/8in -> 3.175mm

      // screw hole for belt tensioner
      translate([belt_x-3.5,9,m3_wide_radius*2+horn_thickness]) rotate([90,0,0]) 
         cylinder(r=m3_wide_radius, h=30, center=true, $fn=22);

      // Screws for linear slider.
      for (x = [-10, 10]) {
         for (y = [-10, 10]) {
            translate([x, y, thickness]) 
               cylinder(r=m3_wide_radius, h=30, center=true, $fn=22);
         }
      }
      // Screws for ball joints.
      translate([-(separation/2)-0.1, horn_y_offset+4, horn_thickness/2]) rotate([0, 90, 0]) 
         cylinder(r=m3_wide_radius, h=15, $fn=22);
      translate([(separation/2)+0.1, horn_y_offset+4, horn_thickness/2]) rotate([0, -90, 0]) 
         cylinder(r=m3_wide_radius, h=15, $fn=22);
      // Lock nuts for ball joints.
      for (x = [-1, 1]) {
         scale([x, 1, 1]) intersection() {
            translate([horn_x, horn_y_offset+4, horn_thickness/2]) rotate([90, 0, -90])
               cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8, center=true, $fn=6);
         }
      }
      translate([horn_x-3, horn_y_offset+4, 10])	  
         cube([4,2*m3_nut_radius,horn_thickness/2],center=true);

      //cutout for belt tensioner
      translate([0,-carriage_height/2+4-0.1,0]) rotate([90,0,180]) 
         linear_extrude(height = carriage_height/2 )
            polygon(points = [[-(tensioner_half_width+tensioner_grip),thickness/3],
                              [-tensioner_half_width,thickness],
                              [-tensioner_half_width,thickness*4],
                              [ tensioner_half_width,thickness*4],
                              [ tensioner_half_width,thickness],
                              [ (tensioner_half_width+tensioner_grip),thickness/3]]);
      if( belt_lock == true )
         translate([-8,5.5-carriage_height/2+4-0.1,thickness-thickness/6+0.1]) 
            cube([12,11,thickness/3+0.2],center=true);
      

      //#cube([belt_x*1.6,carriage_height/3,thickness]);
   }
}

module belt_tensioner_a() 
{
   difference() 
   {
      union() 
      {
         hull() for( x = [-10,10] ) 
         {
            translate([x,0,0]) cylinder(r = m3_wide_radius*2, h = 5, $fn=22 );
         }
            
         hull()
         {
            for( x = [-10,10] ) 
            {
               translate([x-sign(x)*m3_wide_radius*5/2,0,5/2]) cube([m3_wide_radius, m3_wide_radius*4,5], center = true);
            }
            translate([0,3,3]) rotate([90,0,0])
               cylinder(r = m3_wide_radius*2, h=m3_wide_radius*4,$fn=22 );
         }
         
         //add for motor hook here !!!!!!!!!!!!!!!!!!!!!!!!!
         
         
         
         
         //!!!!!!!!!!!!!!!!
      }
      for( x = [-10,10] )
      {
         translate([x,0,-5]) cylinder(r = m3_wide_radius, h = 15, $fn=22 );
      }
      translate([0,10,3]) rotate([90,0,0])
         cylinder(r = m3_wide_radius, h=20,$fn=22 );
      hull()
      {
         translate([-(belt_x-belt_thick/2),10,0]) rotate([90,0,0])
            cylinder(r = belt_thick/2, h=20,$fn=22 ); 
         translate([-horn_x,0,0])
            cube([0.1,20,0.1],center = true ); 
         translate([-(belt_tensioner_brace+corner_radius),0,0])
            cube([0.1,20,0.1],center = true ); 
      }
   }
}

module belt_tensioner_b()
{
   difference()
   {
      union()
      {
         rotate([90,0,180]) 
            linear_extrude(height = carriage_height/2-kerf )
               polygon(points = [[-(tensioner_half_width+tensioner_grip-kerf),thickness/3+kerf],
                                 [-(tensioner_half_width-kerf),thickness],
                                 [-(tensioner_half_width-kerf),thickness],
                                 [ (tensioner_half_width-kerf),thickness],
                                 [ (tensioner_half_width-kerf),thickness],
                                 [ (tensioner_half_width+tensioner_grip-kerf),thickness/3+kerf]]);
         if( belt_lock == true )
         translate([-8,10.8/2,thickness-thickness/6+kerf/2]) 
            cube([11,10.8,thickness/3-kerf],center=true);
         
         translate([0, -1+16, horn_thickness/2+1+0.5])
            color("green") hull() {
               translate([ belt_x-belt_thick-0.5,  -corner_radius+1, 0]) 
                  cube([1.0, 5, horn_thickness-2-1], center=true);
               cylinder(h=horn_thickness-2-1, r=corner_radius, $fn=12, center=true);
            }
         translate([belt_tensioner_brace, -11+16, horn_thickness/2+1+0.5])
            rotate([0, 0, 180]) color("blue") hull() {
               translate([ corner_radius-0.5,  -1 * corner_radius + 1, 0]) 
                  cube([1.0, 5, horn_thickness-2-1], center=true);
               cylinder(h=horn_thickness-2-1, r=corner_radius, $fn=22, center=true);
               translate([ 0,  4, 0]) 
                  cube([2*corner_radius, 0.5*corner_radius, horn_thickness-2-1], center=true);
            }
            
         // difference() {
         hull() {
            translate([0,15,m3_wide_radius*2.5+horn_thickness])
               cube([m3_wide_radius*4,3.8,m3_wide_radius*5],center=true);
            translate([0,15,m3_wide_radius*2.5+horn_thickness])
               cube([m3_wide_radius*6,3.8,m3_wide_radius*2],center=true);
            if(tensioner_short == true )
               translate([0,22,horn_thickness+3]) rotate([90,0,0])
                  cylinder(r = m3_wide_radius*2, h=6,$fn=22 );
         }
         if( tensioner_short == false ) hull() {
            translate([0,2.2,m3_wide_radius*2.5+horn_thickness])
               cube([m3_wide_radius*4,4,m3_wide_radius*5],center=true);
            translate([0,2.2,m3_wide_radius*2.5+horn_thickness])
               cube([m3_wide_radius*6,4,m3_wide_radius*2],center=true);
            translate([0,8,horn_thickness+3]) rotate([90,0,0])
               cylinder(r = m3_wide_radius*2, h=6,$fn=22 );
            translate([0,7.5,horn_thickness])
               cube([m3_wide_radius*2,1,0.01],center=true);
         }
//
      //  cube([m3_wide_radius*4,4,m3_wide_radius*2],center=true);
         //    translate([0,3,0])
         //       cube([m3_wide_radius*2,3,m3_wide_radius*3],center=true);
         //   }
            
      }
      translate([-10,6, thickness]) hull() {
         cylinder(r=m3_wide_radius+kerf, h=30, center=true, $fn=22);
         translate([0,2.5,0])
            cylinder(r=m3_wide_radius+kerf, h=30, center=true, $fn=22);
      }
      
      translate([0,30,horn_thickness+3]) rotate([90,0,0])
         cylinder(r = m3_wide_radius, h=40,$fn=22 );
      if(tensioner_short == true )
         translate([0,16,horn_thickness+3]) rotate([90,0,0])
            cylinder(r = m3_nut_radius, h=3,$fn=6 );
      else
         translate([0,3,horn_thickness+3]) rotate([90,0,0])
            cylinder(r = m3_nut_radius, h=3,$fn=6 );
   }
}
module assembled_carriage() 
{
   carriage();

   translate([0,10,horn_thickness]) belt_tensioner_a();

   translate([0,-16,0]) belt_tensioner_b();
}

module plated_carriage()
{
   
   carriage();

   translate([40,20,0]) belt_tensioner_a();

   translate([40,-16,-thickness/3-kerf]) belt_tensioner_b();
}

//assembled_carriage();
plated_carriage();
