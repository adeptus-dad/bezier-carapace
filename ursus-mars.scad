use <bezier.scad>
use <carapace.scad>


spoolX = -5;
spoolZ = -2;
spoolD = 10;

mov()
{
	color("grey") difference()
	{
		UrsusBody();
		mov(x=1.5)
		{
			$fn=36;
			mov(z=2.5) cylinder(d=5.5, h=20);
			mov(z=3) sphere(d=5); 
		}
	}
	mov(x=7) rot(y=90) color("grey") UrsusClaw();
	mov(x=spoolX, z=spoolZ) rot(x=90) color("lightblue") UrsusSpool();
	color("lightblue") Plating(thickness=1.2, fat=0.5);
	color("orange") difference()
	{
		Plating(thickness=1.6, fat=0.8);
		Plating(thickness=4, fat=0);
	}
	PlatingRivets();
}


// -------- Modules ----------

module UrsusBody()
{
	$fn = 72;
	hull()
	{
		cube([11,3,8], center=true);
		mov(z=0.5) cube([12,6,7], center=true);
	}

	rot(y=90) cylinder(d=6, h=15);
	rot(y=90) mov(z=5) CylinderCog(length=22, r=2.5, n=6);
	rot(y=90) mov(z=10.5) CylinderCog(length=2, r=3.5, n=8);
	rot(y=90) cylinder(d=7, h=9);

	rot(y=90) mov(z=4) for (a=[120, 240, 0]) rot(z=a) mov(x=3.5)
	{
		 cylinder(d=1, h=10);
		 cylinder(d=1.5,h=7);
		 mov(z=10) cylinder(d=1.5,h=1,center=true);
	}

	module vents()
	{
		mov(x=0.5) rot(y=-30) difference() { cylinder(h=6,d1=1,d2=3); cylinder(h=10,d=2.0); }
		mov(x=3.5) rot(y=-30) difference() { cylinder(h=6,d1=1,d2=3); cylinder(h=10,d=2.0); }
		mov(x=6.5) rot(y=-30) difference() { cylinder(h=6,d1=1,d2=3); cylinder(h=10,d=2.0); }
	}
	
	mov(x=3.5) rot(x=120) vents();
	mov(x=3.5) rot(x=-120) vents();
	
	mov(x=spoolX,z=spoolZ) rot(x=90) 
	{
		difference()
		{
			cylinder(d=spoolD+1, h=4, center=true);
			rot(z=30) mov(y=-10) cube(20, true);
		}
		difference()
		{
			mov(z=1) cylinder(d=spoolD+2, h=0.7, center=true);
			rot(z=25) mov(y=-10) cube(20, true);
		}
		difference()
		{
			mov(z=-1) cylinder(d=spoolD+2, h=0.7, center=true);
			rot(z=25) mov(y=-10) cube(20, true);
		}
	}
}

module Plating(thickness=1.2, fat=0)
{
	$fn = 72;
	difference()
	{
		union()
		{
			mov(x=-7-fat, y=-3, z=3.5) cube([18+2*fat, 6, thickness]);
			mov(x=-7-fat, y=3, z=3.5) rot(x=-90) cube([18+2*fat, 6+fat, thickness]);
			mov(x=-7-fat, y=3, z=3.5) rot(y=90) cylinder(h=18+2*fat, r=thickness);
			mov(x=-7-fat, y=-3-thickness, z=3.5) rot(x=-90) cube([18+2*fat, 6+fat, thickness]);
			mov(x=-7-fat, y=-3, z=3.5) rot(y=90) cylinder(h=18+2*fat, r=thickness);
		}
		mov(x=1.5) cylinder(d=7.5-2*fat, h=30);
		hull()
		{
			mov(x=30) cylinder(d=5-2*fat, h=30);
			mov(x=8) cylinder(d=5-2*fat, h=30);
		}
		cube([25, 6, 7], center=true);
		mov(z=-3) cube([15, 30, 6.5-2*fat], center=true);
		mov(x=spoolX,z=spoolZ) rot(x=90) cylinder(d=spoolD-1-2*fat+3, h=20, center=true);
		mov(x=7.5, z=-2.5) rot(x=-90) cylinder(d=5.5-2*fat, h=30, center=true);
	}
}

module PlatingRivets()
{
	mov(x=11.4, y=-3.4, z=5.1) Rivet(1);
	mov(x=11.4, y=3.4, z=5.1) Rivet(1);
	mov(x=-7.4, z=5.1) Rivet(1);
	mov(x=-7.4, y=4.6, z=3.1) Rivet(1);
	mov(x=-7.4, y=-4.6, z=3.1) Rivet(1);
	mov(x=11.4, y=4.6, z=-2.9) Rivet(1);
	mov(x=9.8, y=4.6, z=-2.9) Rivet(1);
	mov(x=0.3, y=4.6, z=-0.1) Rivet(1);
	mov(x=11.4, y=-4.6, z=-2.9) Rivet(1);
	mov(x=9.8, y=-4.6, z=-2.9) Rivet(1);
	mov(x=0.3, y=-4.6, z=-0.1) Rivet(1);
	
}

module UrsusClaw()
{
	$fn = 36;
	length = 15;
	cylinder(d=3,h=12);
	mov(z=12.5) for (a=[-90, 30, 150]) rot(z=a) mov(y=-1) rot(x=60) OneFinger();
	
	module U(width=4, straight=3, height=2)
	{
		hull()
		{
			 cylinder(d=width,h=height,center=true);
			 mov(x=straight/2) cube([straight, width, height], true);
		}
	}
	mov(z=12.2) intersection()
	{
		for (a=[-90, 30, 150]) 
			rot(z=a) mov(y=-2) rot(x=90,y=-90) difference() { U(3.4, 2, 1.6); U(2.2, 6, 4); }
		mov(z=-3) cylinder(d1=10, d2=2, h=7);
	}
	mov(z=10) cylinder(d1=3, d2=4.5, h=1);
	difference()
	{
		mov(z=11) cylinder(d=4.5, h=2.5);
		mov(z=8) cylinder(d=2.5, h=14, center=true);
	}
	cylinder(d=2.2, h=14.5);
	cylinder(d=1.4, h=17);
	mov(z=17) cylinder(d1=1.4, d2=0, h=2.2);
	
	mov(x=2, z=11) rot(y=45) rot(x=180) Chain(link=1.2, n=23, up=90);
}

module OneFinger()
{
	length=8;
	tip = 1.5;
	base = 2;
	hull()
	{
		$fn = 24;
		mov(y=-tip/2, z=length) cylinder(d=tip, h=tip, center=true);
		mov(z=length) cube(tip*0.7, true);
		mov(y=-tip/2) sphere(d=base, true);
		mov(z=base/2) cube(base*0.7, true);
	}
	for (a=[length*0.3:length*0.25:length]) mov(z=a)
	{
		mov(y=tip*0.25) rot(x=-90) cylinder(d1=tip*0.8, d2=0, h=tip);
		mov(y=-tip*1.1) Rivet(2);
	}
	mov(z=length) 
	{
		rot(z=90) rot(y=-30) OneClaw(height=4);
		mov(y=-tip/4,z=tip/4) rot(y=90) 
		{
			cylinder(d=2.0,h=2,center=true);
			cylinder(d=1.0,h=2.4,center=true);
		}
	}
}

module OneClaw(thickness=1.5, height=2.5, factor=4)
{
	diameter = height*factor;
	intersection()
	{
		$fn = 72;
		difference()
		{
			mov(z=length/2) hull()
			{
				cube([thickness, thickness, height], true);
				mov(x=height*factor) cube([0.1, 0.1, height], true);
			}
			mov(z=-1.5*diameter/2) rot(x=90) cylinder(d=1.5*diameter, h=thickness*2, center=true);
		}
		mov(z=height/2-diameter/2) rot(x=90) cylinder(d=diameter, h=thickness*2, center=true);
	}
	mov(z=height/2-diameter/2) for (a=[0:20:50]) rot(y=a) mov(z=diameter/2) Rivet(2);
}

module UrsusSpool()
{
	$fn = 36;
	difference()
	{
		union()
		{
			hull()
			{
				minkowski()
				{
					cylinder(d=spoolD-1, h=6, center=true, $fn=72);
					sphere(0.5);
				}
				cylinder(d=2, h=8.0, center=true);
			}
			intersection()
			{
				hull()
				{
					rot(y=90, z=-38) cylinder(d=2.8, h=20);
					rot(y=90, z=-50) cylinder(d=2.8, h=20);
				}
				cylinder(d=spoolD+1, h=6, center=true, $fn=72);
			}
		}
		hull()
		{
			rot(y=90, z=-38) cylinder(d=2, h=20);
			rot(y=90, z=-50) cylinder(d=2, h=20);
		}
	}
	for (a=[0:30:359]) rot(z=a) mov(x=spoolD/2-1, z=-3.6) Rivet(1);
	for (a=[0:30:359]) rot(z=a) mov(x=spoolD/2-1, z=3.6) Rivet(1);
	mov(z=-3.8) rot(x=180) 
	{
		CylinderCog(length=1, r=1.5, n=8);
		cylinder(h=1.2, d=2, center=true);
	}
	mov(z=3.8) rot(x=0) 
	{
		CylinderCog(length=1, r=1.5, n=8);
		cylinder(h=1.2, d=2, center=true);
	}
}

module Chain(link=2, n=20, up=90)
{
	radius = n*link*180/3.14159/up;
	mov(z=radius) for (i=[0:1:n])
		rot(y=-i*up/n) mov(z=-radius) ChainLink(length=link, odd=i%2);
}


module ChainLink(length=2, odd=false)
{
	$fn=8;
	l = length/2;
	thick = 0.6*length;
	rot(x=odd?45:-45)
	{
		hull() { mov(x=1.5*l, y=l) sphere(d=thick); mov(x=-1.5*l, y=l) sphere(d=thick); }
		hull() { mov(x=1.5*l, y=-l) sphere(d=thick); mov(x=-1.5*l, y=-l) sphere(d=thick); }
		hull() { mov(x=1.5*l, y=l) sphere(d=thick); mov(x=1.5*l, y=-l) sphere(d=thick); }
		hull() { mov(x=-1.5*l, y=l) sphere(d=thick); mov(x=-1.5*l, y=-l) sphere(d=thick); }
	}
}

