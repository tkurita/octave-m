## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} xyplot(@var{XY}, @var{format},...)
##
## plot column wise 2 dimensional matrix @var{XY} as X-Y data.
##
## returned values are handles of line objects.
##
## @end deftypefn

##== History
## 2010-12-28
## * add help of texinfo format.

function lh = xyplot(varargin)
  plotarg = {};
  for n = 1:length(varargin)
    item = varargin{n};
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
  lh = plot(plotarg{:});
endfunction
