## -*- texinfo -*-
## @deftypefn {Function File} {[@var{xy_at_ymax}, @var{ind}] =} ymax(@var{xy}, ["xrange", @var{xrange}])
## 
## return a row acooding to maxmum y
##
## @end deftypefn

function varargout = ymax(xy, varargin)
  if (!nargin)
    print_usage();
    return;
  endif
  if isstruct(xy)
    x = xy.x;
    y = xy.y;
  else
    x = xy(:,1);
    y = xy(:,2);
  endif
  
  if (length(varargin))
    opt = get_properties(varargin, {"xrange"}, {NaN});
    xr = opt.xrange;
    if (isnan(xr))
      error("Unknown options");
    endif
    sxi = find(x >= xr(1))(1);
    exi = find(x > xr(2))(1);
    y2 = y(sxi:exi);
    x2 = x(sxi:exi);
    [y_max, iy] = max(y2);
    target_x = x2(iy);
    iy = iy+sxi-1;
  else
    [y_max, iy] = max(y);
    target_x = x(iy);
  endif
  max_data = [target_x, y_max];

  switch (nargout)
    case (0)
      varargout = {max_data};
    case (1)
      varargout = {max_data};
    case (2)
      varargout = {max_data, iy};
    otherwise
      error ("Too many output arguments");
  endswitch
  
endfunction