include <bezier.scad>
use <spike.scad>
use <dummy.scad>

difference()
{
	Carapace(up=2.0, down=0.2, offset=border/2);
	Carapace(up=4.0, down=4.0, offset=-border/2);
}

toppos = [for (a=[0.17:0.12:0.95]) [a, 0.5]];

intersection()
{
	Carapace(up=2.0, down=0.2, offset=0.0);
	union()
	{
		cube(size=[60, border, 40], center=true);
		PositionOnShell(toppos, Px, Py, Pz)
		{
			rot(z=45) cube(size=[3.0, 3.0, 8], center=true);
		}
	}
}

Carapace(up=1.5, down=0.0, offset=0.0);

PositionOnShell(toppos, Px, Py, Pz)
{
	mov(z=-0.6) Spike(thickness=1.5, size=9);
}

Arrow();
mirror([0,10]) Arrow();



mov(x=15) mov(z=3) color("Tan") Head();
mov(y=20) color("Tan") Laser();
mirror([0,1,0]) mov(y=20) color("Tan") Laser();

// ---------------------

module Arrow()
{
	intersection()
	{
		Carapace(up=2.0, down=0.25, offset=0.0);
		PositionOnShell([[0.72, 0.24]], Px, Py, Pz)
		{
			a = 0.5;
			union()
			{
				rot(z=45) linear_extrude(height=5, center=true) polygon(points=[[0, -a], [4*a, -3*a], [0, 5*a], [-4*a, -3*a]], convexity=10);
			rot(z=45) mov(y=-5) cube(size=[border, 10, 5], center=true);
			}
		}		
	}
}

module Carapace(up=1.0, down=0.0, offset=0, $fn=30)
{
	difference()
	{
		BezierShell(Px, Py, Pz, up=up, down=down, $fn=30);
		Cutoff(offset=offset);
	}
}

module Cutoff(offset=0)
{
	PositionOnShell([[0.85, 0.05], [0.85, 0.95]], Px, Py, Pz)
	{
		mov(z=1.0) sphere(d=12.0-2*offset, center=true, $fn=40);
	}
	PositionOnShell([[0.40, 0.05], [0.40, 0.95]], Px, Py, Pz)
	{
		mov(z=1.0) sphere(d=15.0-2*offset, center=true, $fn=40);
	}
	PositionOnShell([[0.97, 0.5]], Px, Py, Pz)
	{
		mov(x=8.0+offset) cube(size=16.0, center=true);
	}
	mov(z=-5-offset) cube(size=[60, 40, 10], center=true);
	mov(z=-5-offset) mov(x=-18) rot(y=30) cube(size=[60, 40, 10], center=true);
}



