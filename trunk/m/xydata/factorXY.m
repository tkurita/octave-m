## Usage : result = factorXY(xydata, xfactor, yfactor)
##      result = xydata*[xfactor,0;0,yfactor];

function result = factorXY(xydata, xfactor, yfactor)
  result = xydata*[xfactor, 0; 0, yfactor];
endfunction
