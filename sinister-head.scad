include <bezier.scad>

// -------------- Bezier Coordinates --------------

X = [ -20.0, -3.0, 0.0, 10.0 ];
Y1 = [ 2.0, 8.0, 0.0, 0.5 ];
Z1 = [ -2.0, -4.0, -10.0, -20.0 ];
Y2 = [ 8.0, 18.0, 2.0, 8.0 ];
Z2 = [ 6.0, 16.0, -4.0, 6.0 ];

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

// -----------------------------------------

module Head()
{
	$fn=36;
	sphere(d=7.4);
	mov(x=1) rot(y=90) cylinder(d=9.1, h=2, center=true);
	
	mov(z=-1.5) rot(y=-2) mov(x=14)
	{
		// %BezierShell(Px, Py, Pz, up=0.5, down=0.0, $fn=30);
		
		// Trims 
		difference()
		{
			HeadShape(up=1.0, down=0.2, offset=border/2);
			HeadShape(up=4.0, down=1.0, offset=-border/2);
		}
		intersection() // nervure centrale
		{
			HeadShape(up=1.0, down=0.2, offset=0.0);
			cube(size=[60, border, 40], center=true);
		}
		HeadShape(up=0.5, down=0.0, offset=0.0);

		// Head internals
		difference()
		{
			mov(x=-8, z=-4) rot(y=30) for (h=[0:0.8:10]) mov(x=10, z=h) cube(size=[7.5, 8, 0.4], center=true);
			
			HeadShape(up=10.0, down=0.0, offset=0.0);
			InternalsCutoff(offset=-1);
		}
		difference()
		{
			mov(x=-8, z=-4) rot(y=30) mov(x=10, z=5) cube(size=[7.5, 8, 10], center=true);
			
			HeadShape(up=10.0, down=0.0, offset=0.0);
			InternalsCutoff(offset=-2);
		}
		
		// Whiskers
		mov(x=-5.5, z=-3.5) rot(x=120) Whiskers();
		mov(x=-5.5, z=-3.5) rot(x=-120) Whiskers();
		
	}
}


module HeadShape(up=1.0, down=0.0, offset=0, $fn=10)
{
	difference()
	{
		BezierShell(Px, Py, Pz, up=up, down=down, $fn=30);
		Cutoff(offset=offset);
	}
}

module Whiskers()
{
	difference()
	{
		intersection()
		{
			for (a=[0:30:179]) rot(z=a) cube(size=[0.4, 20, 20], center=true);
			
			cylinder(d=5, h=6);
			d = 0.4;
			cylinder(d1=15+2*d, d2=0, h=7.5+d);
		}
		cylinder(d=2.5, h=10);
	}
	
	difference()
	{
		intersection()
		{
			cylinder(d=4, h=5.5);
			d = -0.4;
			cylinder(d1=15+2*d, d2=0, h=7.5+d);
		}
		cylinder(d=1.0, h=10);
	}
}

module InternalsCutoff(offset=0)
{
	// nose
	a = 28;
	mov(x=11.5+offset, z=-5) rot(y=35)
	{
		rot(z=a) cube(size=[12.0, 30.0, 30.0], center=true);
		rot(z=-a) cube(size=[12.0, 30.0, 30.0], center=true);
 	}
	
	// back head
	mov(x=-15.0-offset) cube(size=[6.0, 30.0, 30.0], center=true);
	
}

module Cutoff(offset=0)
{
	// nose
	a = 28;
	mov(x=11.5+offset, z=-5) rot(y=35)
	{
		rot(z=a) cube(size=[12.0, 30.0, 30.0], center=true);
		rot(z=-a) cube(size=[12.0, 30.0, 30.0], center=true);
 	}
	
	// back head
	mov(x=-15.0-offset) cube(size=[6.0, 30.0, 30.0], center=true);
	
	// bottom jaws
	mov(z=-11-offset) rot(y=15) mov(x=-15) cube(size=[20, 40, 10], center=true);
	
	// bottom fangs
	mov(z=-10-offset) rot(y=30) mov(x=5, z=-4) cube(size=[20, 40, 10], center=true);
	mov(x=-5.5, z=-6) rot(x=90) cylinder(r=3.5-offset, h=30, $fn=48, center=true);
}


// ----------------------- WEAPONS -----------------------


module Laser()
{
	$fn=36;
	cube(size=[9, 3.4, 2.4], center=true);
	//rot(x=90) cylinder(d=1, h=20);
	mov(x=-3, y=3.5)
	{
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

// ----------------------- WEAPONS -----------------------



module BoxHead()
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
