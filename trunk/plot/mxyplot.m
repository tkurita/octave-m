## usage : mxyplot([X,Y], format ...)
##         mxyplot(struct("plotarg", {{[X,Y], format ...}}, \
##                          "xlabel", "xname", "ylabel", "yname");
## accept column wise 2 dimensional matrix as X-Y data

function mxyplot(varargin)
  #  plotarg = {};
  #  for i = 1:length(varargin)
  #    item = varargin{i};
  #    if (ischar(item))
  #      plotarg = {plotarg{:}, item};
  #    else
  #      theSize = size(item);
  #      if (theSize(2) == 1) 
  #        plotarg = {plotarg{:}, item};
  #      else
  #        plotarg = {plotarg{:}, item(:,1), item(:,2)};
  #      endif
  #    endif
  #  endfor
  if (isstruct(varargin{1}))
    plotarg = __plot_struct__(varargin{1});
  else
    plotarg = __plot_arg__(varargin{:});
  endif
  mplot(plotarg{:})
endfunction
