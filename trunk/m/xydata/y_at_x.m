function y = y_at_x(xydata, x)
  y = interp1(xydata(:,1), xydata(:,2), x, "linear");
endfunction
