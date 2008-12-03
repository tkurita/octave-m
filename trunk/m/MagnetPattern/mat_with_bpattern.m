## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} mat_with_bpattern(@var{bpattern})
## @seealso{build_pattern, csv_with_bpattern}
##
## @end deftypefn

##== History
## 2008-12-04
## * First implementation

function tb = mat_with_bpattern(@var{bpattern})
  t = bpattern{1}.tPoints(:);
  b = bpattern{1}.bPoints(:);
  for n = 2:length(bpattern)
    t =[t; bpattern{n}.tPoints(:)];
    b =[b; bpattern{n}.bPoints(:)];
  endfor
  tb = [t, b];
endfunction

%!test
%! mat_with_bpattern(x)
