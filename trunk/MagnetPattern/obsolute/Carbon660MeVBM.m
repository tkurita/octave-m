1; #script file
#BM pattern of C6+ 25MeV -> 660MeV
#bPattern=[0,35,60,85,599.2,624.2,649.2;
#	0.3662,0.3662,0.3761,0.4256,1.6473,1.6968,1.7067];

LOADPATH=['./libs:~/share/octave//:' DEFAULT_LOADPATH];

#capture period
tPoints1 = [0,35]; #[msec]
bPoints1 = [0.3299,0.3299]; #[T m]
tLine1 = 25:1:35;
bLine1 = interp1(tPoints1,bPoints1,tLine1,"linear");

#acceleration period
tPoints3 = [85,625.4]; #[msec]
bPoints3 = [0.3889,1.6641]; #[T m]
bSlope = diff(bPoints3)/diff(tPoints3);
tLine3 = 85:1:625.4;
bLine3 = interp1(tPoints3,bPoints3,tLine3,"linear");

#initial acceleration period
tPoints2 = [35,60,85]; #[msec]
bPoints2 = [0.3299,0.3398,0.3889]; #[T m]
tLine2 = 35:1:85;
bLine2 = ppval(splinecomplete(tPoints2,bPoints2,[0,bSlope]),tLine2);

#end of acceleration period
tPoints4 = [625.4,650.4,675.4]; #[msec]
bPoints4 = [1.6641,1.7133,1.7232]; #[T m]
tLine4 = 625.4:1:675.4;
bLine4 = ppval(splinecomplete(tPoints4,bPoints4,[bSlope,0]),tLine4);

# plot(tLine1,bLine1,";capture period;",
#  	tLine2,bLine2,";initial acceleration period;",
#  	tLine3,bLine3,";acceleration period;",
# 	tLine4,bLine4,";end of acceleration period;")

tLine = [tLine1,tLine2,tLine3,tLine4];
bLine = [bLine1,bLine2,bLine3,bLine4];
