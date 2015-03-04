## -*- texinfo -*-
## @deftypefn {Function File} times_for_bpattern(@var{bpatterm}, @var{tstep})
##
## Obtain list of times which include all knots of @var{bpatterm}
##
## @end deftypefn

##== History
##

function retval = times_for_bpattern(bp, ts)
  retval = [];
  for n = 1:length(bp)
    retval = [retval, bp{n}.tPoints(1) : ts : bp{n}.tPoints(1)];
  end
endfunction

%!test
%! times_for_bpattern(x)
