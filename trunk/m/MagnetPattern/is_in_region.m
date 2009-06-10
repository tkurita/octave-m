## -*- texinfo -*-
## @deftypefn {Function File} {@var{bool} =} is_in_region(@var{region}, @{t})
##
## Return 
##
## @end deftypefn

##== History
## 2009-06-10
## * rename isInRegion to is_in_region
## * t can accept vector
## * return element-by-element result of t

function bool = is_in_region(region, t)
  bool = ((region(1) <= t) & (t <= region(end)));
endfunction