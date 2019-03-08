include <bezier.scad>
use <dummy.scad>
use <carapace.scad>

intersection()
{
	import("carapace-alt.stl");
	Carapace(up=14.0, down=4.0, offset=border/2);
}