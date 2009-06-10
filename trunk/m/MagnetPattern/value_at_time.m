## -*- texinfo -*-
## @deftypefn {Function File} {} value_at_time(@var{bpattern}, @var{t})
##
## @end deftypefn

##== History
## 2008-07-28
## * renamed from BValueAtTime

function b = value_at_time(bpattern, t)
  if (!nargin < 2)
    print_usage();
  endif
  # bpattern = BMPattern
  # t = [1,2,3]
  for n = 1:length(bpattern)
    # n = 1 
    r = bpattern{n};
    flags = is_in_range(r.tPoints, t);
    ind = find(flags);
    b = interpRegion(t(ind))
    if (is_in_range(r.tPoints, t))
      b = interpRegion(r,t);
    endif
  endfor
endfunction