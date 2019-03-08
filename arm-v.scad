use <bezier.scad>
use <carapace.scad>

module ArmV()
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
		mov(y=length) cube([20,3.6,2.6], center=true);
	}
}

difference()
{
	ArmV();
	$fn = 36;
	rot(x=90) cylinder(d=3.4, h=8); // ∅3x4mm magnet
}
