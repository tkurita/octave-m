## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} smooth_trapz_table(@var{t}, @var{ys}, @var{ye})
##
## Generate multiple trapezoid slope which share timmings.
##
## @strong{Inputs}
## @table @var
## @item ys
## a vector of values at flat base. 
## @item ye
## a vector of values at flat top.
## @end table
##
## @end deftypefn

function retval = smooth_trapz_table(t, ys, ye)
  if ! nargin
    print_usage();
  endif
  b = [];
  for n = 1:length(ys)
    b(:, end+1) = smooth_trapz(t, ys(n), ye(n));
  endfor
  
  for n = 1:rows(b)
    printf("%5.1f", t(n));
    for k = 1:columns(b)
      printf("\t%7.4f", b(n, k));
    endfor
    printf("\n");
  endfor
endfunction

%!test
%! func_name(x)
