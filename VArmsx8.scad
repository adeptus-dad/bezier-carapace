n=8;


for (i=[0:n-1]) mov(y=i*10)
{
	rot(z=-90) import("stl/arm-v.stl");
	mov(x=11, y=-6, z=2) cube([1,12,1]);
	mov(x=7, y=-2, z=2) cube([5,1,1]);
}



// -------------- Utils --------------



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
