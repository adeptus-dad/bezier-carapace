use <bezier.scad>
use <carapace.scad>

use <ursus-mars.scad>


module claw()
{
	mov(z=5) mov(x=10) rot(y=15) scale(0.75) mars_claw();
	rot(y=60) cylinder(d1=3, d2=0, h=6);
}


for (a=[0:2]) mov(y=a*15)
{
	claw();
	rot(z=180) claw();
}

rot(x=-90) cylinder(d=4, h=30); 