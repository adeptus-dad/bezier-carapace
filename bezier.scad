// M matrix

BinomialM = [
     [ -1,  3, -3, 1 ],
	 [  3, -6,  3, 0 ],
	 [ -3,  3,  0, 0 ],
	 [  1,  0,  0, 0 ]];
	 
function normalized(v) = v/norm(v);
	 
function makeMM(P) = BinomialM*P*BinomialM;
function valUV(MM, u=0, v=0) = [v*v*v, v*v, v, 1] * MM * [u*u*u, u*u, u, 1];
function tanU(MM, u=0, v=0) = [v*v*v, v*v, v, 1] * MM * [3*u*u, 2*u, 1, 0];
function tanV(MM, u=0, v=0) = [3*v*v, 2*v, 1, 0] * MM * [u*u*u, u*u, u, 1];
function point(MMx, MMy, MMz, u=0, v=0) = [
								valUV(MMx, u, v), 
								valUV(MMy, u, v), 
								valUV(MMz, u, v)];
function normal(MMx, MMy, MMz, u=0, v=0) = 
	let(product=cross([tanU(MMx, u, v), tanU(MMy, u, v), tanU(MMz, u, v)],
		 			  [tanV(MMx, u, v), tanV(MMy, u, v), tanV(MMz, u, v)]))
	normalized(product);

function shellPoints(MMx, MMy, MMz, up=1, down=1) = concat(
	[for (v=[0:$fn]) for (u=[0:$fn]) point(MMx, MMy, MMz, u/$fn, v/$fn)+up*normal(MMx, MMy, MMz, u/$fn, v/$fn)],
	[for (v=[0:$fn]) for (u=[0:$fn]) point(MMx, MMy, MMz, u/$fn, v/$fn)-down*normal(MMx, MMy, MMz, u/$fn, v/$fn)]);

function shellFaces() = let(f1=($fn+1), N2=f1*f1) concat(
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ a+f1*b, a+f1*(b+1), a+1+f1*b ]], 
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ a+1+f1*b, a+f1*(b+1), a+1+f1*(b+1) ]],
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ a+f1*b+N2, a+1+f1*b+N2, a+f1*(b+1)+N2 ]], 
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ a+1+f1*b+N2, a+1+f1*(b+1)+N2, a+f1*(b+1)+N2 ]], 
	[for (a=[0:$fn-1]) [ a, a+1, a+N2 ]], 
	[for (a=[0:$fn-1]) [ a+1, a+1+N2, a+N2 ]], 
	[for (a=[0:$fn-1]) [ a+f1*$fn, a+f1*$fn+N2, a+1+f1*$fn ]], 
	[for (a=[0:$fn-1]) [ a+1+f1*$fn, a+f1*$fn+N2, a+1+f1*$fn+N2 ]], 
	[for (a=[0:$fn-1]) [ f1*a, f1*a+N2, f1*(a+1) ]], 
	[for (a=[0:$fn-1]) [ f1*(a+1), f1*a+N2, f1*(a+1)+N2 ]], 
	[for (a=[0:$fn-1]) [ $fn+f1*a, $fn+f1*(a+1), $fn+f1*a+N2 ]], 
	[for (a=[0:$fn-1]) [ $fn+f1*(a+1), $fn+f1*(a+1)+N2, $fn+f1*a+N2 ]]);


module BezierShell(Px, Py, Pz, up=1, down=1, $fn=20)
{
	Mx=makeMM(Px);
	My=makeMM(Py);
	Mz=makeMM(Pz);
	
	polyhedron(
		shellPoints(Mx, My, Mz, up, down), 
		shellFaces(Mx, My, Mz), 
		convexity=10);
};

module PositionOnShell(uvPos, Px, Py, Pz)
{
	Mx=makeMM(Px);
	My=makeMM(Py);
	Mz=makeMM(Pz);
	
	for (i=[0:len(uvPos)-1])
	{
		p = point(Mx, My, Mz, uvPos[i][0], uvPos[i][1]);
		u = normalized([
			tanU(Mx, uvPos[i][0], uvPos[i][1]), 
			tanU(My, uvPos[i][0], uvPos[i][1]), 
			tanU(Mz, uvPos[i][0], uvPos[i][1])]);
		w = normal(Mx, My, Mz, uvPos[i][0], uvPos[i][1]);
		v = cross(w, u);
		mat = [
			[u[0], v[0], w[0], p[0]],
			[u[1], v[1], w[1], p[1]],
			[u[2], v[2], w[2], p[2]],
			[   0,    0,    0,    1]];
		multmatrix(mat) children(0);
	}
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

module CylinderCog(length=10, r=5, n=6)
{
	difference()
	{
		cylinder(h=length, r=r, center=true);
		for (i = [0:n]) rot(z=i*360/n)
			linear_extrude(h=length) polygon(points=[[0,0], [2*r*cos(90/n), 2*r*sin(90/n)], [2*r*cos(90/n), -2*r*sin(90/n)]]);
	}
}

module crown(d=10, n=6)
{
	for (i = [0:n-1]) rot(z=i*360/n) mov(x=d/2) rot(y=90) children();
}

module rectangle(w=10, h=10)
{
	mov(x=h/2, y=w/2) children();
	mov(x=-h/2, y=w/2) children();
	mov(x=h/2, y=-w/2) children();
	mov(x=-h/2, y=-w/2) children();
}

// -------------- Coordinates --------------

X = [ -32.0, -15.0, 16.0, 24.0 ];
Y1 = [ 3.0, 12.0, 12.0, 6.0 ];
Z1 = [-3.0, -0.8, -1.2, -1.2 ];
Y2 = [ 1.0, 12.0, 14.0, 8.0 ];
Z2 = [ -3.0, 21.0, 25.0, 14.0 ];

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


