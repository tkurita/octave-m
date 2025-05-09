## -*- texinfo -*-
## @deftypefn {Function File} {@var{[@var{ts}, @var{te}]} =} time_range_bpattern(@var{bpattern})
##
## Obtain beginning time @var{ts} and endding time @var{te} of @var{bpattern}
##
## @end deftypefn

##== History
## 2010-12-21
## * first implementation

function varargout = time_range_bpattern(bpattern)
  ts = bpattern{1}.tPoints(1);
  te = bpattern{end}.tPoints(end);
  varargout = {ts, te};
endfunction

%!test
%! func_name(x)
