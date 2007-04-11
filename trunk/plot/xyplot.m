## usage : xyplot([X,Y], format ...)
##
## accept column wise 2 dimensional matrix as X-Y data

function xyplot(varargin)
  plotarg = {};
  for i = 1:length(varargin)
    item = varargin{i};
    if (ischar(item))
      plotarg = {plotarg{:}, item};
    else
      theSize = size(item);
      if (theSize(2) == 1) 
        plotarg = {plotarg{:}, item};
      else
        plotarg = {plotarg{:}, item(:,1), item(:,2)};
      endif
    endif
  endfor
  plot(plotarg{:})
endfunction
