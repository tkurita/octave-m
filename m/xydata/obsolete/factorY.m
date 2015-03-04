## Usage : result = factorY(xydata, yfactor)
##      result = [xydata(:,1), xydata(:,2)*yfactor];
## Deprecated. Use calc_xy

function result = factorY(xydata, yfactor)
  warning("factoryY is deprecated. Use calc_xy");
  result = [xydata(:,1), xydata(:,2)*yfactor];
endfunction
