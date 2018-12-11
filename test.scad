use <bezier.scad>



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

Px = [[ -1.8, -1.0, 1.0, 1.8 ],
	  [ -2.0, -1.0, 1.0, 2.0 ],
	  [ -2.0, -1.0, 1.0, 2.0 ],
	  [ -1.8, -1.0, 1.0, 1.8 ]];
	  
Py = [[-0.6,-1.1,-1.1,-0.6 ],
	  [-0.5,-1.5,-1.5,-0.5 ],
	  [ 0.5, 1.5, 1.5, 0.5 ],
	  [ 0.6, 1.1, 1.1, 0.6 ]];
	  
Pz = [[ 0.0, 0.0, 0.0, 0.0 ],
	  [ 1.0, 2.0, 3.0, 1.0 ],
	  [ 1.0, 2.0, 3.0, 1.0 ],
	  [ 0.0, 0.0, 0.0, 0.0 ]];

difference()
{
	BezierShell(Px, Py, Pz, up=0.1, down=0.1, $fn=30);

	positions = [ for (u=[0.05:0.1:0.95]) for (v=[0.05:0.1:0.95]) [u, v] ];
	PositionOnShell(positions, Px, Py, Pz, up=0.1, down=0.1)
	{
		mov(z=-0.3) cylinder(d=0.1, h=0.3);
	}
}

toppos = [for (a=[0.05:0.1:0.95]) [a, 0.5]];
PositionOnShell(toppos, Px, Py, Pz)
{
	mov(z=0.1) sphere(d=0.2, center=true, $fn=40);
}


