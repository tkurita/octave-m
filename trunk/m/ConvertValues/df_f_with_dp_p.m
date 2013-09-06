## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} df_f_with_dp_p(@var{dp_p}, @var{v}, @var{a})
## description
## @strong{Inputs}
## @table @var
## @item dp_p
## delta P/P
## @item v
## velocity
## @item a
## momentum compaction factor.
## @end table
##
## @strong{Outputs}
## df/f = dp/p (a - 1/g^2) 
##
## @end deftypefn

##== History
## 2013-09-06
## * initial implementataion

function retval = df_f_with_dp_p(dp_p, v, a)
  if (!nargin)
    print_usage();
    return;
  endif
  lv = physical_constant("speed of light in vacuum");
  retval = dp_p .* (1 - (v./lv).^2 - a)
endfunction

%!test
%! df_f_with_dp_p(x)
