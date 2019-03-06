include <bezier.scad>
use <dummy.scad>

difference()
{
	difference()
	{
		$fn=36;
		hull()
		{
			mov(z=6) mov(x=-12) cube(size=12, center=true);
			mov(z=9) mov(x=6) cube(size=17, center=true);
			mov(z=2) mov(x=6) cube(size=[16,10,10], center=true);
		}
		hull()
		{
			mov(z=6) mov(x=-12) cube(size=9, center=true);
			mov(z=9) mov(x=6) cube(size=14, center=true);
			mov(z=8) mov(x=6) cube(size=[10,8,20], center=true);
		}
		cylinder(d=8, h=10, center=true);
	}
	BezierShell(Px, Py, Pz, up=20, down=0.4, $fn=30);
}

import("carapace.stl");

mov(x=15) mov(z=3) color("Tan") Head();
mov(y=20) color("Tan") Laser();
mirror([0,1,0]) mov(y=20) color("Tan") Laser();