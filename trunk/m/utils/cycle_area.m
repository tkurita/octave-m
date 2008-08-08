## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} cycle_area(@var{arg})
##
## 一周期分の面積を計算する。
## y data が 0 を横切っている必要がある。
##
## @end deftypefn

##== History
## 2008-07-02
## * first implementation

function retval = cycle_area(xy)
  y0 = 0;
  flags = xy(:,2) > y0;
  
  cflag = flags(1);
  ind = [];
  for n = 1:length(flags)
    if (flags(n) != cflag)
      ind(end+1) = n;
      cflag = flags(n);
    endif
  endfor
  cxs = xy(ind, 1);
  retval = [];
  for m = 1:2:(length(ind) -2)
    c_area = 0;
    for n = m:m+1
      xl = interp1(xy(ind(n)-1:ind(n), 2), xy(ind(n)-1:ind(n), 1), y0);
      xr = interp1(xy(ind(n+1)-1:ind(n+1), 2), xy(ind(n+1)-1:ind(n+1), 1), y0);
      xlist = [xl; xy(ind(n):ind(n+1), 1); xr];
      ylist = [y0; xy(ind(n):ind(n+1), 2); y0];
      c_area += abs(trapz(xlist, ylist));
    endfor
    retval(end+1) = c_area;
  endfor
endfunction