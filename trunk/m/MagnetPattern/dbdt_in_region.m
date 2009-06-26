## -*- texinfo -*-
## @deftypefn {Function File} {} dbdt_in_region(@var{r}, @var{t})
##
## Return gradients [T/msec] at @var{t} [msec].
##
## @var{r} is a region which have folloing fields.
##
## @table @code
## @item funcType
## @item tPoints
## @item bPoints
## @end table
## @end deftypefn

##== History
## 2009-06-10
## * first implementation

function retval = dbdt_in_region(r, t)
  switch (r.funcType)
    case("linear")
      retval = r.grad(1);
    case("spline")
      # r = BMPattern(){2};
      pp = splinecomplete(r.tPoints, r.bPoints, r.grad);
      # t = 35:1:85
      #pp1 = csape(r.tPoints, r.bPoints, "complete", r.grad) #don't works
      #plot(t, ppval(pp1,t), r.tPoints, r.bPoints)
      retval = ppgrad(pp, t);
#      b = ppval(pp, t)
#      db = gradient(b)
#      plot(t, db, "-;db;", t, retval, "-;retval;");
  endswitch
endfunction


