## -*- texinfo -*-
## @deftypefn {Function File} {@var{bool} =} is_in_range(@var{r}, @{x})
##
## Return
## @example
## ((r(1) <= x) & (x <= r(end)))
## @end example
##
## @end deftypefn

##== History
## 2009-06-10
## * rename isInRegion to is_in_range
## * t can accept vector
## * return element-by-element result of t

function bool = is_in_range(r, x)
  bool = ((r(1) <= x) & (x <= r(end)));
endfunction