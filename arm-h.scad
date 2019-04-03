use <bezier.scad>
use <carapace.scad>

module ArmH()
{
	$fn=72;
	length=10.5;
	sphere(d=8.5);
	difference()
	{
		union()
		{
			mov(x=1.2) rot(x=-90) rot(y=4) 
			{
				 cylinder(d=3.2, h=length); 
				 cylinder(d=4.5, h=4.2); 
				 mov(z=3.8) crown(d=4.5, n=8) Rivet(1);
				 mov(z=length-5) cylinder(d=4.5, h=5); 
				 mov(z=length-5+0.4) crown(d=4.5, n=8) Rivet(1);
				 mov(z=length-1.6) rot(x=90) { cylinder(d=5.2, h=6, center=true); cylinder(d=3.5, h=7.5, center=true); }
			 }
			mov(x=-1.2) rot(x=-90) rot(y=-9) 
			{ 
				cylinder(d=2.0, h=length);
				cylinder(d=3.3, h=4.27); 
				mov(z=3.8) crown(d=3.3, n=6) Rivet(1);
				mov(z=length-4.0) cylinder(d=3.3, h=5); 
				mov(z=length-4.0+0.4) crown(d=3.3, n=6) Rivet(1);
			 	mov(z=length-1.4) rot(x=90) { cylinder(d=4.0, h=5, center=true); cylinder(d=3.0, h=6.5, center=true); }
			}
		}
		mov(y=9.5+length) cube(size=20, center=true);
	}
	mov(y=length+4.4) rot(y=-8)
	{
		cylinder(h=4, d=4);
		sphere(d=4);
		mov(z=3.4) 
		{
			TopPlate(thickness=1.2, fat=0.5);
			difference()
			{
				TopPlate(thickness=1.6, fat=0.8);
				TopPlate(thickness=4, fat=0);
			}
			PlateRivets(thickness=1.6, fat=0.8);
		}
		mov(z=2.6)
		{
			rot(z=20) mov(y=-3) cube([2, 6, 2], center=true);
			rot(z=-20) mov(y=-3) cube([2, 6, 2], center=true);
		}
	}
	
}

difference()
{
	ArmH();
	$fn = 36;
	rot(x=90) cylinder(d=3.4, h=8); // ∅3x4mm magnet
}

module TopPlate(thickness=1.2, fat=0)
{
	L = 10+2*fat;
	W = 12+2*fat;
	difference()
	{
		intersection()
		{
			mov(x=-L/2, y=-7-fat) cube(size=[L,W,thickness]);
			mov(y=-W+4+fat, z=-2*thickness) cylinder(h=4*thickness, d=2*W);
		}
		mov(x=-L/2-0.5+fat, y=-7, z=-2*thickness) cylinder(h=4*thickness, d=5-2*fat);
		mov(x= L/2+0.5-fat, y=-7, z=-2*thickness) cylinder(h=4*thickness, d=5-2*fat);
	}
}

module PlateRivets(thickness=1.2, fat=0)
{
	L = 10;
	W = 12;
	mov(z=thickness)
	{
		mov(y=-4.8)
		{
			mov(x=L/2+fat/2) Rivet(1);
			mov(x=-L/2-fat/2) Rivet(1);
		}
		mov(y=3.2)
		{
			mov(x=L/2+fat/2) Rivet(1);
			mov(x=-L/2-fat/2) Rivet(1);
		}
		mov(y=-7-fat/2)
		{
			mov(x=-3.4) Rivet(1);
			mov(x=3.4) Rivet(1);
		}
	}
}
