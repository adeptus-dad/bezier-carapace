include <bezier.scad>

module Head()
{
	$fn=36;
	sphere(d=7.4);
	mov(x=1) rot(y=90) cylinder(d=9.1, h=2, center=true);
	difference()
	{
		mov(z=1) rot(y=20) mov(x=9.4) cube(size=[20.8, 12.5, 10.3], center=true);
		mov(x=-9) cube(size=20, center=true);
	}
}


module Laser()
{
	cube(size=[12, 3.4, 2.4], center=true);
	mov(x=-3, y=3.5)
	{
		$fn=36;
		cube(size=[18.4, 7, 11.6], center=true);
		mov(z=2.4)
		{	
			mov(x=9.2) rot(y=90) cylinder(d=4.7, h=6.4);
			mov(x=9.2) rot(y=90) cylinder(d=4.1, h=25.2);
		}
		mov(z=-2.4)
		{	
			mov(x=9.2) rot(y=90) cylinder(d=4.7, h=6.4);
			mov(x=9.2) rot(y=90) cylinder(d=4.1, h=25.2);
		}
	}
}

Laser();