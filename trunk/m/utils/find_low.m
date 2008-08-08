## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function retval = find_low(ylist, varargin)
  [hbin, threshold] = get_properties(varargin, {"bin", "threshold"}, {200, 5});
  [yh, xh] = hist(ylist, hbin);
  bar(xh, yh);
  py = yh(1);
  start_ind  = 1;
  for n = 1:length(yh);
    if (yh(n) >=  threshold)
      start_ind = n;
      break;
    endif
  endfor
  
  [ym, yi] = max(yh >=  threshold);
  
  py = yh(yi);
  for n = yi:length(yh)
    if (yh(n) < py);
      yi = n-1;
      break;
    endif
    py = yh(n);
  endfor  
  retval = xh(yi);
  vline(retval);
endfunction