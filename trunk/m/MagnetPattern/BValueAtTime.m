## usage : b = BValueAtTime(BPattern, t)

function b = BValueAtTime(BPattern, t)
  for i = 1:length(BPattern)
	 theRegion = BPattern{i};
	 if (isInRegion(theRegion.tPoints, t))
	   b = interpRegion(theRegion,t);
	 endif
  endfor
endfunction