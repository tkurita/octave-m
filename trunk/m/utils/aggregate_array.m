## -*- texinfo -*-
## @deftypefn {Function File} {} aggregate_array(@var{xy}, @var{step}, ["centerx"])
##
## If the option "centerx" is given, x values are averages of x values correspoinding to aggregating y values. 
## 
## @end deftypefn

##== History
## 2008-05-03
## * added the option "centerx"
## * Without the option "centerx", the x value is first x of aggregated data.
## 
## 2008-05-01
## * initial implementation

function retval = aggregate_array(xy, step, varargin)
  x = [];
  y = [];
  [centerx] = get_properties(varargin,{"centerx"},{false});
  if (centerx)
    resolve_x = @mean;
  else
    resolve_x = @first_x;
  end

  for n = 1:step:rows(xy)
    try
      x(end+1) = resolve_x(xy(n:n+step-1, 1));
      y(end+1) = sum(xy(n:n+step-1, 2));
    catch
      break;
    end_try_catch
  end
  
  retval = [x(:), y(:)];
endfunction

function retval = first_x(vals)
  retval = vals(1);
endfunction
  