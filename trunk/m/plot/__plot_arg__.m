## usage : plotarg = __plot_arg__([X,Y], format ...)
##         plotarg = __plot_arg__([X,Y], [X2,Y2] ...)
##
## = Result
## {X, Y, format...}
## {X, Y, X2, Y2...}
function plotarg = __plot_arg__(varargin)
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
endfunction
