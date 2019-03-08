use <bezier.scad>

w = 9.34;
h = 6.10;
L = 12;
axis = w/2-h/2;

hull()
{
	$fn = 36;
	mov(z=-h/4) cube([0.5,w,h/2], center=true);
	mov(y=axis) rot(y=90) cylinder(d=h, h=0.5, center=true);
	mov(y=-axis) rot(y=90) cylinder(d=h, h=0.5, center=true);
}
rot(y=-90) inside();
mov(y=axis+0.5) gatling();
mov(y=-axis-0.5) gatling();
difference()
{
	$fn = 36;
	l = 2.5;
	mov(x=l/2) hull()
	{
		mov(z=-h/4) cube([l,w,h/2], center=true);
		mov(y=axis) rot(y=90) cylinder(d=h, h=l, center=true);
		mov(y=-axis) rot(y=90) cylinder(d=h, h=l, center=true);
	}
	mov(x=l/2) hull()
	{
		e = 0.41;
		mov(z=-h/4) cube([2*l,w-2*e,h/2-2*e], center=true);
		mov(y=axis) rot(y=90) cylinder(d=h-2*e, h=2*l, center=true);
		mov(y=-axis) rot(y=90) cylinder(d=h-2*e, h=2*l, center=true);
	}
	mov(x=4.2) rot(y=22) cube([5,20,20], center=true);
	mov(x=3.8) for (a=[-1:1:1.5]) mov(y=a*1.2) cube([4,0.5,10], center=true);
}

// ------ modules --------

module inside()
{
	$fn = 12;
	d = h-2*1.5;
	hull() { mov(y=axis) cylinder(d=d, h=2); mov(y=-axis) cylinder(d=d, h=2); }
	mov(x=h/4, z=1) cube([h/2,2.3,2], center=true);
	mov(x=-h/4, z=1) cube([h/2,4.3,2], center=true);
}

module gatling()
{
	D = 2.9;
	rot(y=-90) 
	{
		rot(z=12) crown(d=D, n=6) barrel();
	}
	rot(y=90) 
	{
		$fn=12;
		cylinder(d=D, h=L-2);
		cylinder(d=0.8, h=L-0.2);
	}
}

module barrel()
{
	$fn = 24;
	diam = 1.5;
	rot(y=90) 
	{
		difference()
		{
			cylinder(d=diam, h=L);
			mov(z=L) cylinder(d=0.8, h=2, center=true);
		}
		mov(z=L-2) cylinder(d=diam+0.4, h=0.8, center=true);
	}
	
}