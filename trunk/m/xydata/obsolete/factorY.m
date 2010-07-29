## Usage : result = factorY(xydata, yfactor)
##      result = [xydata(:,1), xydata(:,2)*yfactor];
## Deprecated. Use calc_xy

function result = factorY(xydata, yfactor)
  result = [xydata(:,1), xydata(:,2)*yfactor];
endfunction
