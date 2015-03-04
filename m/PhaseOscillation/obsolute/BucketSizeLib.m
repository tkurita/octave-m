1; ##script file

##define functions
function y = fhiEq(x)
  ## x : phase angle which give separatrix
  global phi_s; # phase angle of synchronus particle
  #phi_s
  y = cos(phi_s) + cos(x) - (pi - phi_s - x).*sin(phi_s);
endfunction

function deltaEmax = RFBucketHeight(vList, Ee, eta, h, phi_s)
  ## synchronus particle の位相が phi_s の時の RF Bucket Height を計算する。
  ## 単位は、[eV]
  y = maxHalfHeight(phi_s);
  deltaEmax = sqrt(e .* vList) .* y .* (beta./sqrt(h)).*sqrt(Ee./(pi.*eta));
endfunction

function [phi1,info] = solvePhi1()
  ## separatrix を与える位相（saddle point でないもう一方）を計算する
  ## fhiEq(x) = 0によって与えられる。
  ## phi1 : saddle point でない separatrix を与える位相
  ## info : fhiEq(x) = 0 が解けたら 1
  ## saddle point : phi_2 = pi- phi_s
  global phi_s;
  if (phi_s < pi/2) 
	## after transition
	initialValue = -(pi - phi_s);
  else
	## before transition
	initialValue = pi+phi_s;
  endif

  [phi1,info] = fsolve("fhiEq", initialValue);
endfunction

function y = maxHalfHeight(phi_s)
  ## bucket height を計算する
  ## 結果は、位相の時間微分
  y = abs(sqrt(2 .*(cos(phi_s) - (pi/2 - phi_s).*sin(phi_s) )));
endfunction

function y = halfHeight(x)
  ## bucket half height at phase angle x
  ## when x = phi_s, give maximum buket half height Y(Gamma)
  ## あらかじめ solvePhi1 を使って、phi_1 を計算しておく必要がある。
  global phi_s; #phase angle of shychronus particle
  global phi_1; #phase angle which give separatrix
#   if (phi_s < pi/2 )
# 	transitionFlag = 1;
#   else
# 	transitionFlag = -1;
#   endif
#   y = sqrt(transitionFlag.*(cos(x) - cos(phi_1) + (x - phi_1).*sin(phi_s)) );
  y = sqrt(abs(cos(x) - cos(phi_1) + (x - phi_1).*sin(phi_s)) );
endfunction

function y = halfHeight(x)
  ## bucket half height at phase angle x
  ## when x = phi_s, give maximum buket half height Y(Gamma)
  global phi_s; #phase angle of shychronus particle
  global phi_1; #phase angle which give separatrix
  if (phi_s < pi/2 )
	transitionFlag = 1;
  else
	transitionFlag = -1;
  endif
  y = sqrt(transitionFlag.*(cos(x) - cos(phi_1) + (x - phi_1).*sin(phi_s)) );
endfunction

function [alphaArea,yHeight, phi1]=calcBucketSize(fs)
  ## fs : RF phase angle of synchronus particle
  ##      can not accept matrix, fs must be a scaler value
  ## results 
  ## alphaArea : normalized bucket area
  ## yHeight : normalized bukcket half height

  global phi_s;
  global phi_1;
  phi_s = fs;
  [phi_1,info] = solvePhi1();
  #phi_s
  #phi_1
  if (phi_s < pi/2)
	[alphaArea, IER, NFUN, ERR] = quad("halfHeight", phi_1, pi - fs);
  else
	[alphaArea, IER, NFUN, ERR] = quad("halfHeight", pi -fs, phi_1);
  endif
  alphaArea = (1/(4*sqrt(2))).*alphaArea;
  yHeight=halfHeight(phi_s);
  phi1=phi_1;
endfunction

function bucketEnvelopSet = bucketEnvelop(fs)
  global phi_s;
  global phi_1;
  phi_s = fs;
  [phi_1,info] = solvePhi1();
  phi_2 = pi - phi_s;
  if (phi_s < pi/2)
	## after transition
	plotRange = phi_1:0.01:(phi_2+pi/4);
  else
	## before transition
	plotRange = (phi_2-pi/4):0.01:phi_1;
	if (plotRange(length(plotRange)) != phi_1)
	  plotRange = [plotRange,phi_1];
	endif
  endif
  bucketEnvelopList =  (1/(8*sqrt(2))).*halfHeight(plotRange);
  bucketEnvelopSet = [plotRange;bucketEnvelopList];
endfunction

function plotBucketEnvelop(fs)
  bucketEnvelopSet = bucketEnvelop(fs);
  gset ytics mirror;
  graw("unset y2tics\n");
  graw("unset y2label\n");
  gset ylabel ""
  gset xlabel "phase angle of RF [degree]"
  gset xzeroaxis linetype 0;
  gset yzeroaxis linetype 0;
  synchronusPoint = [fs*360/(2*pi),0];
  bucketEnvelopSet(1,:) = bucketEnvelopSet(1,:)*360/(2*pi);

  gplot bucketEnvelopSet' title '' with lines 1,\
 	  ([bucketEnvelopSet(1,:);-bucketEnvelopSet(2,:)])' title '' with lines 1,\
	  synchronusPoint title "" with points 
endfunction

