## -*- texinfo -*-
## @deftypefn {Function File} {} tickslabel_off(@var{axis_name})
## @deftypefnx {Function File} {} tickslabel_off(@var{ah}, @var{axis_name})
##
## Hide label of ticks.
##
## @end deftypefn

##== History
## 2011-01-06
## * First implementation

function retval = tickslabel_off(varargin)
  if ishandle(varargin{1}) 
    ax = varargin{1};
    varargin = varargin(2:end);
  else
    ax = gca;
  endif
  
  axspec = varargin{1};
  tickname = [axspec, "tick"];
  ticklabel = [axspec, "ticklabel"];
  
  current_ticks = get(ax, tickname);
  set(ax, ticklabel, {});
  set(ax, tickname, current_ticks);
endfunction

%!test
%! tickslabel_off("x")
