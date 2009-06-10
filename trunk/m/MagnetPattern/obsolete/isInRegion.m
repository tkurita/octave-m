
##== History
## 2009-06-10
## * t can accept vector
## * return element-by-element result of t

function bool = isInRegion(theList, t)
  warning("isInRegion is obsolete. Use is_in_range.");
  bool = ((theList(1) <= t) & (t <= theList(end)));
endfunction