// M matrix

BinomialM = [
     [ -1,  3, -3, 1 ],
	 [  3, -6,  3, 0 ],
	 [ -3,  3,  0, 0 ],
	 [  1,  0,  0, 0 ]];
	 
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
	product/norm(product);

function shellPoints(MMx, MMy, MMz, up=1, down=1) = concat(
	[for (v=[0:$fn]) for (u=[0:$fn]) point(MMx, MMy, MMz, u/$fn, v/$fn)+up*normal(MMx, MMy, MMz, u/$fn, v/$fn)],
	[for (v=[0:$fn]) for (u=[0:$fn]) point(MMx, MMy, MMz, u/$fn, v/$fn)-down*normal(MMx, MMy, MMz, u/$fn, v/$fn)]);

function shellFaces() = let(f1=($fn+1), N2=f1*f1) concat(
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ (a)+f1*(b),   (a+1)+f1*(b),   (a)+f1*(b+1) ]], 
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ (a+1)+f1*(b), (a+1)+f1*(b+1), (a)+f1*(b+1) ]],
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ (a)+f1*(b)+N2,   (a+1)+f1*(b)+N2,   (a)+f1*(b+1)+N2 ]], 
	[for (b=[0:$fn-1]) for (a=[0:$fn-1]) [ (a+1)+f1*(b)+N2, (a+1)+f1*(b+1)+N2, (a)+f1*(b+1)+N2 ]], 
	[for (a=[0:$fn-1]) [ (a)+f1*(0), (a)+f1*(0)+N2, (a+1)+f1*(0) ]], 
	[for (a=[0:$fn-1]) [ (a+1)+f1*(0), (a+1)+f1*(0)+N2, (a)+f1*(0)+N2 ]], 
	[for (a=[0:$fn-1]) [ (a)+f1*($fn), (a)+f1*($fn)+N2, (a+1)+f1*($fn) ]], 
	[for (a=[0:$fn-1]) [ (a+1)+f1*($fn), (a+1)+f1*($fn)+N2, (a)+f1*($fn)+N2 ]], 
	[for (a=[0:$fn-1]) [ (0)+f1*(a), (0)+f1*(a)+N2, (0)+f1*(a+1) ]], 
	[for (a=[0:$fn-1]) [ (0)+f1*(a+1), (0)+f1*(a+1)+N2, (0)+f1*(a)+N2 ]], 
	[for (a=[0:$fn-1]) [ ($fn)+f1*(a), ($fn)+f1*(a)+N2, ($fn)+f1*(a+1) ]], 
	[for (a=[0:$fn-1]) [ ($fn)+f1*(a+1), ($fn)+f1*(a+1)+N2, ($fn)+f1*(a)+N2 ]]);


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
