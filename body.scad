include <bezier.scad>
use <dummy.scad>
use <carapace.scad>
use <spike.scad>
use <arm-v.scad>

difference()
{
	$fn=72;
	
	union()
	{
		difference()
		{
			hull()
			{
				mov(z=6) mov(x=-14) cube(size=12, center=true);
				mov(z=13) mov(x=6) cube(size=[14,18,23], center=true);
				mov(z=2) mov(x=6) cube(size=[16,14,10], center=true);
			}
			Interior();
			BezierShell(Px, Py, Pz, up=20, down=0.4, $fn=30);
			mov(x=2) cylinder(d=8, h=10, center=true);
			mov(x=16.5, z=3.5) sphere(d=7.8);
		}
		shoulder();
		mirror([0,1,0]) shoulder();
	}
	
	mov(x=-3, y=8, z=3) sphere(d=9);
	mov(x=-3, y=-8, z=3) sphere(d=9);
}

mov(x=5, z=7) cube([1,16,2], center=true);

module shoulder()
{
	$fn=72;
	mov(x=-3, y=8, z=3) rot(x=-98) 
	{
		difference()
		{
			mov(z=-1.5)
			{ 
				cylinder(d=10.5, h=4.9, center=true); 
				mov(z=1.5) CylinderCog(length=2.5, r=11.0/2, n=12);
			}
			mov(z=-1.5) cylinder(d=9.5, h=5.5);
		}
	}
}


module Interior()
{
	hull()
	{
		mov(z=6) mov(x=-12) cube(size=9, center=true);
		mov(z=9) mov(x=4.5) cube(size=14, center=true);
		mov(z=8) mov(x=6) cube(size=[10,8,20], center=true);
	}
}

// Collar
mov(x=13.2, z=3.5) rot(y=90) difference()
{
	dia = 13;
	$fn=72;
	cylinder(d=dia, h=2);
	cylinder(d=dia-2, h=6, center=true);
}

// Lamps
module Lamp()
{
	$fn=72;
	mov(x=12.4, z=0) rot(y=110) 
	{
		dia = 3;
		mov(z=1.5) sphere(d=dia-1);
		difference()
		{
			cylinder(d=dia, h=2);
			cylinder(d=dia-1, h=6, center=true);
		}
	}
}
mov(y=7, z=-1) rot(x=40) Lamp();
mov(y=-7, z=-1) rot(x=-40) Lamp();

module Doors()
{
	w = 4;
	h = 5;
	d = 0.3;
	difference()
	{
		x = h;
		y = 2*w;
		cube([x, y, 0.6], center=true);
		cube([x-2*d, y-2*d, 2], center=true);
	}
	
	module door()
	{
		minkowski()
		{
			cube([h-4*d, w-3*d, 0.1], center=true);
			D8(d);
		}
		rectangle(w-4.5*d, h-5.5*d) mov(z=d+0.05) Rivet(0);
	}
	mov(y=-w/2+d/2) door();
	mov(y=w/2-d/2) door();
	rectangle(2*w-d, h-d) mov(z=0.3) Rivet(0);
}
mov(x=11, z=-2.9) rot(x=180) color("tan") Doors();

mov(x=-15.5) rot(y=6.5) for (a=[-4:1.0:4]) mov(y=a) cube([10,0.6,2], center=true); 


//color("darkgrey") import("carapace-final.stl");
//mov(x=-3, y=8, z=3) color("orange") ArmV();
// #Dummies();






