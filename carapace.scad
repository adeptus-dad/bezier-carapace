use <bezier.scad>
use <spike.scad>

module mov(x=0, y=0, z=0)
{
    translate([x, y, z])
    children();
}

module rot(x=0, y=0, z=0)
{
    rotate([x, y, z])
    children();
}

X = [ -26.0, -15.0, 16.0, 22.0 ];
Y1 = [ 3.0, 8.0, 16.0, 3.0 ];
Z1 = [-3.0, -0.2, -0.2, -0.2 ];
Y2 = [ 1.0, 10.0, 18.0, 6.0 ];
Z2 = [ -3.0, 17.0, 22.0, 10.0 ];

Px = [[X[0]+4, X[1], X[2], X[3]],
	  [X[0]+2, X[1], X[2], X[3]],
	  [X[0]+2, X[1], X[2], X[3]],
      [X[0]+4, X[1], X[2], X[3]]];	  
Py = [[-Y1[0], -Y1[1], -Y1[2], -Y1[3] ],
	  [-Y2[0], -Y2[1], -Y2[2], -Y2[3] ],
	  [ Y2[0],  Y2[1],  Y2[2],  Y2[3] ],
	  [ Y1[0],  Y1[1],  Y1[2],  Y1[3] ]];
Pz = [Z1, Z2, Z2, Z1];
	  
border = 0.9;

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



