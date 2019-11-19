## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} xyplot(@var{XY}, @var{format},...)
## plot @var{XY}.
##
## @var{XY} is a column wise 2 dimensional matrix or a structure which has fields of "x" and "y".
##
## returned values are handles of line objects.
##
## @end deftypefn

function lh = xyplot(varargin)
  plotarg = {};
  for n = 1:length(varargin)
    item = varargin{n};
    if (ischar(item))
      plotarg{end+1} = item;
    else
      if isstruct(item)
        plotarg = {plotarg{:}, item.x, item.y};
      elseif (columns(item) == 2) 
        plotarg = {plotarg{:}, item(:,1), item(:,2)};
      else
        plotarg{end+1} = item;
      endif
    endif
  endfor
  lh = plot(plotarg{:});
endfunction
