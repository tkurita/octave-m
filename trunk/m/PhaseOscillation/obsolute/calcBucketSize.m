## usage : [alphaArea,yHeight, phi1]=calcBucketSize(fs)
## fs : RF phase angle of synchronus particle
##      can not accept matrix, fs must be a scaler value
## results 
## alphaArea : normalized bucket area
## yHeight : normalized bukcket half height

function [alphaArea, yHeight, phi1]=calcBucketSize(fs)
  ## debug
#   printf("start calcBucketSize\n");
#   fs
  
  [phi1,info] = solvePhi1(fs);

  global _phi_s;
  _phi_s = fs; #halfHeight で必要
  global _phi_1;
  _phi_1 = phi1; #halfHeight で必要
  
  #printf("start quad\n");
  if (fs < pi/2)
	[alphaArea, IER, NFUN, ERR] = quad("halfHeight", phi1, (pi-fs));
  else
	[alphaArea, IER, NFUN, ERR] = quad("halfHeight", (pi-fs), phi1);
  endif
  alphaArea = (1/(4*sqrt(2))).*alphaArea;
  yHeight=halfHeight(fs);

  #printf("end calcBucketSize\n");
endfunction
