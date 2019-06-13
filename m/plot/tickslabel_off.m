## -*- texinfo -*-
## @deftypefn {Function File} {} tickslabel_off(@var{axis_name})
## @deftypefnx {Function File} {} tickslabel_off(@var{ah}, @var{axis_name})
##
## Hide label of ticks.
##
## @strong{Example}
## @example
## plot(x);
## tickslabel_off("x", "y")
## @end example
##
## @end deftypefn

function retval = tickslabel_off(varargin)
  if ishandle(varargin{1}) 
    ax = varargin{1};
    varargin = varargin(2:end);
  else
    ax = gca;
  endif
  
  for n = 1:length(varargin)
    axspec = varargin{n};
    tickname = [axspec, "tick"];
    ticklabel = [axspec, "ticklabel"];
    
    # current_ticks = get(ax, tickname);
    set(ax, ticklabel, {});
    #set(ax, tickname, current_ticks);
  endfor
endfunction

%!test
%! tickslabel_off("x")
