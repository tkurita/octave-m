## Usage : [near_data, index] = nearX([x, y], target_x)
##         near_data = nearY([x, y], target_x)
##      return a xy value of rearest data to target_x
##
## Deprecated. use xy_near_x

function varargout = nearX(xydata, target_x)
  warning("nearX is deprecated. Use xy_near_x");
  
  target_index = 0;
  if (xydata(1,1) >= target_x)
    target_index = 1;
  else
      for n = 2:rows(xydata)
        if (xydata(n,1) > target_x)
          if ((xydata(n,1) - target_x) < (target_x - xydata(n-1,1)))
            target_index = n;
          else
            target_index = n-1;
          endif
          
          break;
        endif
        
      endfor
  endif
  
  if (target_index == 0)
    target_index = rows(xydata)
  endif
  near_data = xydata(target_index, :);
  switch (nargout)
    case (0)
      varargout = {near_data};
    case (1)
      varargout = {near_data};
    case (2)
      varargout = {near_data, target_index};
    otherwise
      error ("Too many output arguments");
  endswitch
  
endfunction