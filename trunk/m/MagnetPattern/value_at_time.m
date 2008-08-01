## usage : b = value_at_time(BPattern, t)

##== History
## 2008-07-28
## * renamed from BValueAtTime

function b = value_at_time(BPattern, t)
  for i = 1:length(BPattern)
    theRegion = BPattern{i};
    if (isInRegion(theRegion.tPoints, t))
      b = interpRegion(theRegion,t);
    endif
  endfor
endfunction