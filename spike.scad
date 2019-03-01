
module Spike(thickness=1, size=6)
{
	hull()
	{
		translate([0, 0, 0]) D8(s=thickness/2);
		translate([0, 0, 0.5*size]) D8(s=thickness/2);
	}
	
	translate([0, 0, size*0.3])
	difference()
	{
		intersection()
		{
			intersection()
			{
				resize([size*0.6, size*0.6, size]) D8();
				cube(size=[2*size, thickness, 2*size], center=true);
			}
			translate([0, 0, 4*size]) cube(size=8*size, center=true);
		}
		hole = size*0.08;
		translate([ hole,0,0]) rotate([90,0,0]) cylinder(h=2*thickness, d=2*hole, center=true, $fn=30);
		translate([-hole,0,0]) rotate([90,0,0]) cylinder(h=2*thickness, d=2*hole, center=true, $fn=30);
		translate([ hole,0,0]) rotate([0,-30,0]) translate([0, 0, -4*size]) cube(size=8*size, center=true);
		translate([-hole,0,0]) rotate([0, 30,0]) translate([0, 0, -4*size]) cube(size=8*size, center=true);
	}
};


module D8(s=1)
{
	points = [
		[ 0, 0, s ],
		[ s, 0, 0 ],
		[ 0, s, 0 ],
		[-s, 0, 0 ],
		[ 0,-s, 0 ],
		[ 0, 0,-s ]];
	faces = [
		[ 0, 1, 2 ],
		[ 0, 2, 3 ],
		[ 0, 3, 4 ],
		[ 0, 4, 1 ],
		[ 5, 1, 4 ],
		[ 5, 4, 3 ],
		[ 5, 3, 2 ],
		[ 5, 2, 1 ]];
	polyhedron(points, faces, 10);	
};

Spike();