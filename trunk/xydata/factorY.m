## Usage : result = factorY(xydata, yfactor)
##      result = [xydata(:,1), xydata(:,2)*yfactor];

function result = factorY(xydata, yfactor)
  result = [xydata(:,1), xydata(:,2)*yfactor];
endfunction
