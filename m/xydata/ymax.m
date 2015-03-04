## -*- texinfo -*-
## @deftypefn {Function File} {[@var{val}, @var{ind} =} ymax(@var{xy}, ["xrange", @var{xrange}])
## 
## return a row acooding to maxmum y
##
## @end deftypefn

##== History
## 2009-06-02
## * add "xrange" property.
##
## 2008-02-20
## * renamed from maxY

function varargout = ymax(xy, varargin)
  if (!nargin)
    print_usage();
    return;
  endif
  
  if (length(varargin))
    opt = get_properties(varargin, {"xrange"}, {NaN});
    xr = opt.xrange;
    if (isnan(xr))
      error("Unknown options");
    endif
    x = xy(:,1);
    sxi = find(x >= xr(1))(1);
    exi = find(x > xr(2))(1);
    xy2 = xy(sxi:exi,:);
    [max_data, iy] = ymax(xy2);
    iy = iy+sxi-1;
  else
    [y_max, iy] = max(xy(:,2));
    target_x = xy(iy,1);
    max_data = [target_x, y_max];
  endif
  
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