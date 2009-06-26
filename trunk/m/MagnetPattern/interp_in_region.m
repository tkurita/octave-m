## useage : b = interp_in_region(bRegion,t)
## t : [msec] can accept vector data
## bRegion have a structure which have following members
##   .funcType,tPoints,bPoints
## require splinecomplete.m

##== History
## 2009-06-10
## * renamed form interpRegion

function b = interp_in_region(bRegion,t)
  # bRegion = patternSet{n}
  # csape(bRegion.tPoints, bRegion.bPoints, "complete", bRegion.grad)
  switch (bRegion.funcType)
    case("linear")
      b = interp1(bRegion.tPoints,bRegion.bPoints,t,"linear");
    case("spline")
      b = ppval(splinecomplete(bRegion.tPoints,bRegion.bPoints,bRegion.grad),t);
  endswitch
endfunction
