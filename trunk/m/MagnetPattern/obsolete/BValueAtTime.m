## usage : b = BValueAtTime(BPattern, t)

function b = BValueAtTime(BPattern, t)
  warning("BValueAtTime is deprecated. Use value_at_time.");
  for i = 1:length(BPattern)
	 theRegion = BPattern{i};
	 if (isInRegion(theRegion.tPoints, t))
	   b = interpRegion(theRegion,t);
	 endif
  endfor
endfunction