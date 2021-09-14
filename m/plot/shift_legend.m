## -- retval = func_name(ax, dxdy)
##     shift position of legend
##
##  * Inputs *
##    ax : axes handle
##    dxdy : [dx, dy]
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function h = shift_legend(ax, dxdy)
  if ! nargin
    print_usage();
    return;
  endif

  h = get(ax, "__legend_handle__")
  p = get(h, "position");
  set(h, "position", [p(1)+dxdy(1), p(2)+dxdy(2), p(3), p(4)]);
endfunction

%!test
%! func_name(x)
