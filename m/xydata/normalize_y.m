## -- retval = normalize_y(xy, [maxy = 1])
##    Scale y value to maxy.
##
##    * Inputs *
##    arg1 : 
##
##    * Outputs *
##    output of function
##    
##    * Exmaple *
##
##    See also: 

function retval = normalize_y(xydata, maxy = 1)
  if ! nargin
    print_usage();
    return;
  endif

  x = xydata(:,1);
  y = xydata(:,2);
  retval = [x, y.*maxy./max(y)];
endfunction


%!test
%! func_name(x)
