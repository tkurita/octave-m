## BM pattern of H+ 10MeV -> 200MeV
1; #script file
## bPattern=[0,35,60,85,599.2,624.2,649.2;
##	0.3662,0.3662,0.3761,0.4256,1.6473,1.6968,1.7067];
## require splinecomplete.m

#LOADPATH=['~/share/octave:' DEFAULT_LOADPATH];

function [bLine, tLine, bPoints_set] = MagnetPattern(varargin)
  ## usage [bLine, tLine, bPoints_set] = MagnetPattern(tStep,startTime,endTime)
  ## tStep : time interval [msec]
  ## bLine : BL value [T*m]

  tStep = varargin{1};

  ## capture period
  tPoints1 = [0,35]; #[msec]
  bPoints1 = [0.3662,0.3662]; #[T m]
  tLine1 = 25:tStep:35;
  bLine1 = interp1(tPoints1,bPoints1,tLine1,"linear");

  ## acceleration period
  tPoints3 = [85,599.2]; #[msec]
  bPoints3 = [0.4256,1.6473]; #[T m]
  bSlope = diff(bPoints3)/diff(tPoints3);
  if (tStep < 1)
	tLine3 = (85+tStep):tStep:599.2;
  else
	tLine3 = (85+tStep):tStep:599;
  endif
  bLine3 = interp1(tPoints3,bPoints3,tLine3,"linear");

  ## initial acceleration period
  tPoints2 = [35,60,85]; #[msec]
  bPoints2 = [0.3662,0.3761,0.4256]; #[T m]
  tLine2 = (35+tStep):tStep:85;
  bLine2 = ppval(splinecomplete(tPoints2,bPoints2,[0,bSlope]),tLine2);

  ## end of acceleration period
  tPoints4 = [599.2,624.2,649.2]; #[msec]
  bPoints4 = [1.6473,1.6968,1.7067]; #[T m]
  if (tStep < 0.1)
	tLine4 = (599.2+tStep):tStep:649.2;
  else
	tLine4 = 600:tStep:649;
  endif
  bLine4 = ppval(splinecomplete(tPoints4,bPoints4,[bSlope,0]),tLine4);

  tLine = [tLine1,tLine2,tLine3,tLine4];
  bLine = [bLine1,bLine2,bLine3,bLine4];

  bPoints_set = [[tPoints1,tPoints2,tPoints3,tPoints4];[bPoints1,bPoints2,bPoints3,bPoints4]]';

  #plotMagnetPattern(tLine1,bLine1,tLine2,bLine2,tLine3,bLine3,tLine4,bLine4);

  if (length(varargin) > 1)
	startTime = varargin{2};
	if (tLine(1) > startTime)
	  headdingTime = startTime:tStep:(tLine(1)-tStep);
	  tLine = [headdingTime,tLine];
	  headdingB(1:length(headdingTime)) = bLine(1);
	  bLine = [headdingB, bLine];
	elseif (tLine(1) < startTime)
		n = 1;
		while(tLine(n) < startTime)
		  n++;
		endwhile
		tLine = tLine(n:length(tLine));
		bLine = bLine(n:length(bLine));
	endif
  endif
  
  if (length(varargin) > 2)
	endTime = varargin{3};
	if (last(tLine) < endTime)
	  enddingTime = (last(tLine)+tStep):tStep:endTime;
	  tLine = [tLine,enddingTime];
	  enddingB(1:length(enddingTime)) = last(bLine);
	  bLine = [bLine,enddingB];
	elseif (last(tLine) > endTime)
	  n = length(tLine)-1;
	  while(tLine(n) > endTime)
		n--;
	  endwhile
	  tLine = tLine(1:n);
	  bLine = bLine(1:n);
	endif

  endif
endfunction

function plotMagnetPattern(tLine1,bLine1,tLine2,bLine2,tLine3,bLine3,tLine4,bLine4)
  tLine = [tLine1,tLine2,tLine3,tLine4];
  bLine = [bLine1,bLine2,bLine3,bLine4];
  plot(tLine1,bLine1,";capture period;",
	   tLine2,bLine2,";initial acceleration period;",
	   tLine3,bLine3,";acceleration period;",
	   tLine4,bLine4,";end of acceleration period;");
endfunction
