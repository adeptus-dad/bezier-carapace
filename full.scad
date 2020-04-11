include <bezier.scad>
use <carapace.scad>
use <dummy.scad>
use <spike.scad>
use <arm-v.scad>


color("darkgrey") import("stl/carapace.stl");
#color("darkgrey") import("stl/body.stl");
mov(x=-3, y=8, z=3) color("orange") import("stl/arm-v.stl");
mov(x=-3, y=-8, z=3) rot(z=180) color("orange") import("stl/arm-v.stl");

mov(x=15) mov(z=3.5) Head();
Dummies();
