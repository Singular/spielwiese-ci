LIB "tst.lib";
tst_init();
ring Rq=(0,Q),(x,y,z),dp; //U_q(so_3)
matrix C[3][3];
matrix D[3][3];
C[1,2]=Q2;
C[1,3]=1/Q2;
C[2,3]=Q2;
D[1,2]=-Q*z;
D[1,3]=1/Q*y;
D[2,3]=-Q*x; 
system("PLURAL",C,D);
poly Cq=Q^4*x2+y2+Q^4*z2+Q*(1-Q^4)*x*y*z;
poly C1=x^3+x;
poly C2=y^3+y;
poly C3=z^3+z;
ideal I=Cq,C1,C2,C3;
I=std(I);
module a=syz(I);
print(a);
tst_status(1);$
