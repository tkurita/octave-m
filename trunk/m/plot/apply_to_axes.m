## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} apply_to_axes(@var{propname}, @var{value})
## change property @var{propname} of each axis object of the current figure.
## @strong{Inputs}
## @table @var
## @item propname
## property name
## @item value
## new value to set to @var{propname}.
## @end table
##
## @end table
##
## @end deftypefn

##== History
## 2014-09-15
## * first implementaion

function retval = apply_to_axes(propname, value)
  if ! nargin
    print_usage();
  endif
  
  ax = findobj(gcf, "type", "axes");
  
  for n = 1:length(ax)
    set(ax(n), propname, value);
  endfor
endfunction

%!test
%! func_name(x)