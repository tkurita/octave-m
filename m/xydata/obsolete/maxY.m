## Usage : [max_data, imax] = maxY([x, y])
##         max_data = maxY([x, y])
##      return a pair value of maxmum y
##
## obsolete. Use ymax
function varargout = maxY(xydata)
  warning("maxY is obosolete. Use ymax");
  [y_max, iy] = max(xydata(:,2));
  target_x = xydata(iy,1);
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