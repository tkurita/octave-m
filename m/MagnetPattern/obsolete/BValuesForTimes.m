## usage [bLine, tLine] = BValuesForTimes(patternSet, tStep, startTime, endTime)
##
## BValuesForTimes is deprecated. Use bvalues_for_period.
##
##= Parameters
## tStep : time interval [msec]
## startTime and endTime can be ommited.
##
##= Result
## bLine : BL value [T*m]

function [bLine, tLine] = BValuesForTimes(patternSet, varargin)
  warning("BValuesForTimes is deprecated. Use bvalues_for_period.")
  # patternSet = BMPattern
  # timeInfo = {1,35,85}
  timeInfo = varargin;
  tStep = timeInfo{1};
  
  tPoints = patternSet{1}.tPoints;
  tLine = timeLine(tPoints,tStep);
  bLine = interpRegion(patternSet{1},tLine);
  
  nRegion = length(patternSet);
  for n = 2:nRegion
    #patternSet{i}
    # n = 2;
    # 
    tPoints = patternSet{n}.tPoints;
    tLineTmp = timeLine(tPoints,tStep);
    bLineTmp = interpRegion(patternSet{n},tLineTmp);
    tLine = [tLine,tLineTmp];
    bLine = [bLine,bLineTmp];
  endfor
  
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
    if (tLine(end) < endTime)
      enddingTime = (tLine(end)+tStep):tStep:endTime;
      tLine = [tLine,enddingTime];
      enddingB(1:length(enddingTime)) = bLine(end);
      bLine = [bLine,enddingB];
    elseif (tLine(end) > endTime)
      n = length(tLine)-1;
      while(tLine(n) > endTime)
        n--;
      endwhile
      tLine = tLine(1:n);
      bLine = bLine(1:n);
    endif
    
  endif
endfunction

function tLine = timeLine(tPoints,tStep)
  if (tStep < 1)
    tLine = (tPoints(1)+tStep):tStep:tPoints(end);
  else
    tLine = roundup(tPoints(1)):tStep:rounddown(tPoints(end));
  endif
  
endfunction
