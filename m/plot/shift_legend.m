## -- retval = shift_legend(h, dxdy)
##     shift position of legend
##
##  * Inputs *
##    h : axes handle or legend handle
##    dxdy : [dx, dy]
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function h = shift_legend(h, dxdy)
  if ! nargin
    print_usage();
    return;
  endif

  if !strcmp(get(h, "tag"), "legend")
    h = get(h, "__legend_handle__");
  endif
  p = get(h, "position");
  set(h, "position", [p(1) + dxdy(1), p(2) + dxdy(2), p(3), p(4)]);
endfunction

%!test
%! func_name(x)
