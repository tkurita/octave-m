## usage : [alphaArea,yHeight, phi1]=rfbucket_size(fs)
## fs : RF phase angle of synchronus particle
##      can not accept matrix, fs must be a scaler value
## results 
## alphaArea : normalized bucket area
## yHeight : normalized bukcket half height

##== History
## 2010-12-23
## * use rfbucket_half_height instead of halfHeight
##
## 2010-12-21
## * renamed from calcBucketSize
## * used solve_phi1 instead of solvePhi1

function [alphaArea, yHeight, phi1]=rfbucket_size(fs)
  # fs = 0.26
  
  [phi1,info] = solve_phi1(fs);
  
  global _phi_s;
  _phi_s = fs; #rfbucket_half_height で必要
  global _phi_1;
  _phi_1 = phi1; #rfbucket_half_height で必要
  
  #printf("start quad\n");
  if (fs < pi/2)
    [alphaArea, IER, NFUN, ERR] = quad(@rfbucket_half_height, phi1, (pi-fs));
  else
    [alphaArea, IER, NFUN, ERR] = quad(@rfbucket_half_height, (pi-fs), phi1);
  endif
  alphaArea = (1/(4*sqrt(2))).*alphaArea;
  yHeight=rfbucket_half_height(fs);

  #printf("end rfbucket_size\n");
endfunction
