## Usage : result = factorX(xydata, xfactor)
##      result = [xydata(:,1)*xfactor, xydata(:,2)];

function result = factorX(xydata, xfactor)
  result = [xydata(:,1)*xfactor, xydata(:,2)];
endfunction
