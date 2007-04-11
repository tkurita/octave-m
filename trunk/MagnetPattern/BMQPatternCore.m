function [bLine, tLine, bPoints_set] = BMQPatternCore(varargin)
  ## usage [bLine, tLine, bPoints_set] = BMQPattern(tStep,tPoints1,bPoints1,...
  ##                                               startTime,endTime)
  ## tStep : time interval [msec]
  ## bLine : BL value [T*m]

  
  timeInfo = varargin{1};
  tStep = timeInfo{1};

  ## capture period
  tPoints1 = varargin{2}; #[msec]
  bPoints1 = varargin{3}; #[T m]
  tLine1 = tPoints1(1):tStep:tPoints1(2);
  bLine1 = interp1(tPoints1,bPoints1,tLine1,"linear");

  ## acceleration period
  tPoints3 = varargin{6}; #[msec]
  bPoints3 = varargin{7}; #[T m]
  bSlope = diff(bPoints3)/diff(tPoints3);
  if (tStep < 1)
	tLine3 = (tPoints3(1)+tStep):tStep:tPoints3(2);
  else
	tLine3 = (tPoints3(1)+tStep):tStep:rounddown(tPoints3(2));
  endif
  bLine3 = interp1(tPoints3,bPoints3,tLine3,"linear");

  ## initial acceleration period
  tPoints2 = varargin{4}; #[msec]
  bPoints2 = varargin{5}; #[T m]
  tLine2 = (tPoints2(1)+tStep):tStep:last(tPoints2);
  bLine2 = ppval(splinecomplete(tPoints2,bPoints2,[0,bSlope]),tLine2);

  ## end of acceleration period
  tPoints4 = varargin{8}; #[msec]
  bPoints4 = varargin{9}; #[T m]
  if (tStep < 1)
	tLine4 = (tPoints4(1)+tStep):tStep:last(tPoints4);
  else
	tLine4 = roundup(tPoints4(1)):tStep:rounddown(last(tPoints4));
  endif
  bLine4 = ppval(splinecomplete(tPoints4,bPoints4,[bSlope,0]),tLine4);

  tLine = [tLine1,tLine2,tLine3,tLine4];
  bLine = [bLine1,bLine2,bLine3,bLine4];

  bPoints_set = [[tPoints1,tPoints2,tPoints3,tPoints4];[bPoints1,bPoints2,bPoints3,bPoints4]]';

  if (length(timeInfo) > 1)
	startTime = timeInfo{2};
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
  
  if (length(timeInfo) > 2)
	endTime = timeInfo{3};
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
