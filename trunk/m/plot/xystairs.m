## -*- texinfo -*-
## @deftypefn {Function File} {@var{xys} =} xystairs(@var{xy})
##
## [xs, ys] = stairs(@var{xy}(:,1), @var{xy}(:.2));
## @var{xys} = [xs, ys];
##
## Use with xyplot.
##
## xyplot(xystairs(xy), ";stairs plot;")
## @end deftypefn

##== History
## 2008-05-03
## * First implementation.

function retval = xystairs(xy)
  [xs, ys] = stairs(xy(:,1), xy(:,2));
  retval = [xs, ys];
endfunction