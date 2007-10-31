function b = interpRegion(bRegion,t)
  ## useage : b = interpRegion(bRegion,t)
  ## t : [msec] can accept vector data
  ## bRegion have a structure which have following members
  ##   .funcType,tPoints,bPoints
  ## require splinecomplete.m
  
  # bRegion = patternSet{n}
  # csape(bRegion.tPoints, bRegion.bPoints, "complete", bRegion.grad)
  switch (bRegion.funcType)
    case("linear")
      b = interp1(bRegion.tPoints,bRegion.bPoints,t,"linear");
    case("spline")
      b = ppval(splinecomplete(bRegion.tPoints,bRegion.bPoints,bRegion.grad),t);
  endswitch
endfunction
