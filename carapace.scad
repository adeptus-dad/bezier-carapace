include <bezier.scad>
use <spike.scad>
use <dummy.scad>

toppos = [for (a=[0.17:0.12:0.95]) [a, 0.5]];

CarapaceFinal();

module CarapaceFinal()
{
	difference(vents=true)
	{
		//import("carapace.stl");
		CarapaceSmooth();
		RightVents();
		mirror([0,1,0]) RightVents();
	}

	RightRivets();
	mirror([0,1,0]) RightRivets();
}


module RightRivets()
{
	PositionOnShell(toppos, Px, Py, Pz)
	{
		mov(y=0.75, z=3.5) Rivet(3);
	}
	
	borderRivets = 
	[
		[27/60, 13.65/60],
		[20.3/60, 2/60],
		[33.7/60, 1.3/60],
		[47.6/60, 1.4/60],
		[56.6/60, 19.6/60],
		[47.6/60, 17.15/60],
		[43.6/60, 6/60],
		[14.6/60, 2.6/60],
		[8.95/60, 14/60]
	];
	
	PositionOnShell(borderRivets, Px, Py, Pz)
	{
		mov(z=2) Rivet(2);
	}
	
	PositionOnShell([for (a=[0.4:0.035:0.7]) [a, 0.35]], Px, Py, Pz)
	{
		mov(z=1.5) Rivet(2);
	}
}

module RightVents()
{
	$fn=12;
	PositionOnShell([[16/60, 0.26]], Px, Py, Pz)
	rot(z=0) for (a=[-2.5:1.2:3.0001])
		mov(x=a) hull()
		{
			mov(y=3) cylinder(d=0.6, h=4, center=true);
			mov(y=-3) cylinder(d=0.6, h=4, center=true);
		}
}

module CarapaceSmooth()
{
	difference()
	{
		Carapace(up=2.0, down=0.2, offset=border/2);
		Carapace(up=4.0, down=4.0, offset=-border/2);
	}

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


	intersection() // Arrow 1
	{
		Carapace(up=2.0, down=0.0, offset=0.0);
		PositionOnShell([[0.79, 0.29]], Px, Py, Pz)
		{
			rot(z=47) Arrow(0.3);
		}	
	}
	intersection() // Arrow 1
	{
		Carapace(up=2.0, down=0.0, offset=0.0);
		PositionOnShell([[0.79, 1-0.29]], Px, Py, Pz)
		{
			rot(z=180-47) Arrow(0.3);
		}	
	}
	intersection() // Arrow 2
	{
		Carapace(up=2.0, down=0.0, offset=0.0);
		PositionOnShell([[0.72, 0.1], [0.72, 1-0.1]], Px, Py, Pz)
		{
			rot(z=90) Arrow(0.3);
		}		
	}
}


// ---------------------

module Arrow(a=0.2, fleury=true)
{
	if (fleury)
	{
		s = 0.5 * a;
		linear_extrude(height=5, center=true) mov(y=-.39)  scale([s, s, s]) import("fleury.svg", convexity=3);
	}
	else
	{
		difference()
		{
			$fn=24;
			linear_extrude(height=5, center=true) polygon(points=[[0, 9*a], [-6*a, -4*a], [6*a, -4*a]], convexity=10);
			mov(x=4.5*a, y=-4.5*a) cylinder(d=5*a, h=5, center=true);
			mov(x=-4.5*a, y=-4.5*a) cylinder(d=5*a, h=5, center=true);
		}
	
		mov(y=-5) cube(size=[4*a, 10, 5], center=true);
	}
}

module Carapace(up=1.0, down=0.0, offset=0, $fn=30)
{
	difference()
	{
		BezierShell(Px, Py, Pz, up=up, down=down, $fn=60);
		Cutoff(offset=offset);
	}
}

module Cutoff(offset=0)
{
	PositionOnShell([[0.93, 0.12], [0.93, 0.88]], Px, Py, Pz)
	{
		mov(z=1.0) sphere(d=15.0-2*offset, $fn=40);
	}
	PositionOnShell([[0.45, 0.07], [0.45, 0.93]], Px, Py, Pz)
	{
		mov(z=1.0) sphere(d=15.0-2*offset, $fn=40);
	}
	PositionOnShell([[0.97, 0.5]], Px, Py, Pz)
	{
		mov(x=8.0+offset) cube(size=16.0, center=true);
	}
	mov(z=-5-offset) cube(size=[60, 40, 10], center=true);
	mov(z=-5-offset) mov(x=-18) rot(y=30) cube(size=[60, 60, 10], center=true);
}

module Rivet(n=1)
{
	$fn=24;
	mov(z=0.0) sphere(d=0.2+n*0.2);
}

