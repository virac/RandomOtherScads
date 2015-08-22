tot_height = 22.7-10 ;
short_height = 4 ;

diff_height = tot_height - 2*short_height;

echo(short_height);
echo(short_height+diff_height);

for( i=[0:1] ) for( j=[0:2] ) rotate([0,0,i*180+j*60]) translate([0,12,0]) difference(){
	union() {
		cylinder( r = 3.6, h = short_height+i*diff_height, $fn = 20 );
		cylinder( r = 5, h = short_height+i*diff_height-0.6, $fn = 20 );
	}
	translate([0,0,-0.1]) union() {
		cylinder( r = 2.8, h = 2*tot_height, $fn = 20 );
	}
}