## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} dp_p_with_frev(@var{f0}, @var{f1}, @var{a}, @var{C})
## description
## @strong{Inputs}
## @table @var
## @item f0
## Base frequency
## @item f1
## A frequency varing from @var{f0}. f1 = f0 + df
## @item a
## momentum compaction factor.
## @item C
## circumference in [m]
## @end table
##
## @strong{Outputs}
## dp/p = 1/(a - 1/g^2) df/f
##
## @end deftypefn

##== History
## 2013-08-16
## * initial implementataion

function retval = dp_p_with_frev(f0, f1, a, C)
  if (!nargin)
    print_usage();
    return;
  endif
  lv = physical_constant("speed of light in vacuum");
  v = C.*f0;
  retval = (f1 - f0)./f0./(1 - (v./lv).^2 - a);
endfunction

%!test
%! dp_p_with_frev(x)
