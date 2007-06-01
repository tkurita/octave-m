## usage : a_span = span_struct(tPoints, bPoints, funcType)
##  make a span structure to compose magnet pattern.
##
##== fields of span structure
## * tPoints -- [msec]
## * bPoints -- value of magnet at tPoints
## * funcType -- kind of function. must be "linear" or "spline"

function a_span = span_struct(tPoints, bPoints,funcType)
  a_span.tPoints = tPoints;
  a_span.bPoints = bPoints;
  a_span.funcType = funcType;
  a_span.grad = gradient(blist)./gradient(tlist);
endfunction