## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} windowsize(@var{width}, @var{height})
## change plot window size
##
## @end deftypefn

##== History
## 2014-11-13
## * first implementaion

function retval = windowsize(w, h)
  if ! nargin
    print_usage();
  endif
  pre_pos = get(gcf, "position");
  set(gcf, "position", [pre_pos(1), pre_pos(2), w, h]);
endfunction

%!test
%! windowsize(x)
