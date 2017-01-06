// A configurable fan size adapter
// Create by : Sherif Eid
// sherif.eid@gmail.com

// v 1.0.2  : fixed bug in sizing the fan plates
// v 1.0.1  : fixed output fan cone to tube size, increased size of fan opening
// v 1.0    : first release

// Here goes design variables, dimensions are in mm

// fans' parameters
// wall thickness
t_wall = 2.5;
// fan 1: diameter
d_fan1 = 140;
// fan 1: distance between screw openings
ls_fan1 = 124.5;  
// fan 1: screw openings' diameter
ds_fan1 = 5;  
// fan 2: diameter
d_fan2 = 120;  
// fan 2: distance between screw openings
ls_fan2 = 105;
// fan 2: screw opening diameters
ds_fan2 = 5;   

// larger fan cone parameters
// length to manifold elbow  
l_mani1 = 10;
// cone angle
a_cone = 179;
// length to manifold elbow  
l_mani2 = round(d_fan2/(2*tan(a_cone/2)));

// manifold parameters
// manifold angle
a_mani = 0;     
// z-axis rotation angle of the manifold elbow
az_mani = 0;     
// internal parameters
// pipe reduction ratio relative to fan 1 diameter
n_pipe = 1;
// angle factor
n_angle = 0.501;

// other advanced variables
// used to control the resolution of all arcs 
$fn = 90;        

// modules library
module fanplate(d,ls,t,ds) 
{
    /*
    d   : diameter of the fan
    ls  : distance between screws
    t   : wall thickness
    ds  : diameter of screws 
    */
    difference()
    {
        difference()
        {
            difference()
            {
                difference()
                {
                    //translate([d*0.1+d/-2,d*0.1+d/-2,0]) minkowski()
                    translate([-0.45*d,-0.45*d,0]) minkowski()
                        { 
                         //cube([d-2*d*0.1,d-2*d*0.1,t/2]);
                         cube([d*0.9,d*0.9,t/2]);
                         cylinder(h=t/2,r=d*0.05);
                        }
                    translate([ls/2,ls/2,-0.1]) cylinder(d=ds,h=t+0.2);
                }
                translate([ls/-2,ls/2,-0.1]) cylinder(d=ds,h=t+0.2);
            }
            translate([ls/-2,ls/-2,-0.1]) cylinder(d=ds,h=t+0.2);
        }
        translate([ls/2,ls/-2,-0.1]) cylinder(d=ds,h=t+0.2);
    }
}

module mani_elbow(a,d,t,az)
{
    // this is the manifold elbow
    // a  : angle of the elbow
    // d  : diameter of the elbow
    // t  : wall thickness
    
    rotate([0,0,az]) translate([-1*n_angle*d,0,0]) rotate([-90,0,0]) difference()
    {
        difference()
        {  
            difference()
            {
                rotate_extrude() translate([n_angle*d,0,0]) circle(r = d/2);
                rotate_extrude() translate([n_angle*d,0,0]) circle(r = (d-2*t)/2);
            }
            translate([-2*d,0,-2*d]) cube([4*d,4*d,4*d]);
        }
        rotate([0,0,90-a]) translate([-4*d,-2*d,-2*d]) cube([4*d,4*d,4*d]);
    }
}

// body code goes here
offset_1 = 0 ;//-(ls_fan1-ls_fan2)/2;
offset_2 = (ls_fan1-ls_fan2)/2;

module fan_thing() 
{
   difference() // fan 1 plate + pipe 
   {
      union()
      { 
         difference() {
            fanplate(d=d_fan1,ds=ds_fan1,t=t_wall*2,ls=ls_fan1);  // fan 1 plate
            translate([offset_1-0.5*d_fan2-0.5,offset_2-0.5*d_fan2+0.5,t_wall]) 
                  cube([d_fan2+1,d_fan2+1,t_wall+0.2]);
         }
         translate([offset_1,offset_2,0]) fanplate(d=d_fan2,ds=ds_fan2,t=t_wall,ls=ls_fan2);  // fan 2 plate
      }
      translate([offset_1,offset_2,-0.1]) cylinder(d=n_pipe*d_fan2-2*t_wall,h=l_mani2+t_wall+0.2);
     // translate([0,0,-0.1]) cylinder(d1=n_pipe*d_fan1-2*t_wall,d2=n_pipe*d_fan2-2*t_wall,l_mani2+t_wall+0.2);
      
      for(i=[[1,1],[-1,1],[-1,-1],[1,-1]])
      {
         translate([i[0]*ls_fan2/2+offset_1,i[1]*ls_fan2/2+offset_2,-0.1]) cylinder(d=ds_fan2,h=t_wall+0.2);
      }
   }
}

fan_thing();
//translate([-140,0,0]) mirror([1,0,0])

/*difference() // fan 1 plate + pipe 
{
   union()
   { 
      difference() {
         fanplate(d=d_fan1,ds=ds_fan1,t=t_wall*2,ls=ls_fan1);  // fan 1 plate
         translate([-(ls_fan1-ls_fan2)/2-0.5*d_fan2-0.5,(ls_fan1-ls_fan2)/2-0.5*d_fan2+0.5,t_wall]) 
               cube([d_fan2+1,d_fan2+1,t_wall+0.2]);
      }
      translate([-(ls_fan1-ls_fan2)/2,(ls_fan1-ls_fan2)/2,0]) fanplate(d=d_fan2,ds=ds_fan2,t=t_wall,ls=ls_fan2);  // fan 2 plate
   }
   translate([offset_1,offset_2,-0.1]) cylinder(d=n_pipe*d_fan2-2*t_wall,h=l_mani2+t_wall+0.2);
  // translate([0,0,-0.1]) cylinder(d1=n_pipe*d_fan1-2*t_wall,d2=n_pipe*d_fan2-2*t_wall,l_mani2+t_wall+0.2);
   
   for(i=[[1,1],[-1,1],[-1,-1],[1,-1]])
   {
      translate([i[0]*ls_fan2/2+offset_1,i[1]*ls_fan2/2+offset_2,-0.1]) cylinder(d=ds_fan2,h=t_wall+0.2);
   }
}*/






