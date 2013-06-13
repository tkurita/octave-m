## Usage : result = factorXY(xydata, xfactor, yfactor)
##      result = xydata*[xfactor,0;0,yfactor];

function result = factorXY(xydata, xfactor, yfactor)
   warning("factoryXY is deprecated. Use calc_xy");
  result = xydata*[xfactor, 0; 0, yfactor];
endfunction
