function bool = isInRegion(theList, t)
  bool = ((theList(1) <= t)&&(t <= last(theList)));
endfunction