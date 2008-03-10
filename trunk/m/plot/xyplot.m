## usage : xyplot([X,Y], format ...)
##
## accept column wise 2 dimensional matrix as X-Y data

function result = xyplot(varargin)
  plotarg = {};
  for i = 1:length(varargin)
    item = varargin{i};
    if (ischar(item))
      plotarg{end+1} = item;
    else
      if (columns(item) == 2) 
        plotarg = {plotarg{:}, item(:,1), item(:,2)};
      else
        plotarg{end+1} = item;
      endif
    endif
  endfor
  result = plot(plotarg{:});
endfunction
