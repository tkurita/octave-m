## -*- texinfo -*-
## @deftypefn {Function File} {} elements_on_plot(@var{names}, @var{lattice}, "property", value...)
##
## Show element nemas in lattice on plot
##
## Parameters
## @table @code
## @item @var{names}
## A cell array of regular expressions to specify names of elements.
## @item @var{lattice}
## A lattice object.
## @end table
##
## Optional Properties
## @table @code
## @item "yposition"
## Vertical position of element names. The value is string or number. e.g., "graph 0", "first 0". If a number x is given, it means "first x".
## @item "clear"
## clear text on plot before making new text on plot. No value. May no actual effect on Octave 3.
## @end table
## @end deftypefn

##= History
## 2008-04-30
## * Help written by texinfo format.
## * element names are specified with regular expressions.
## 
## 2008-04-24
## * Fiexed a problem wht "yposition" is negative.
## 
## 2008-04-12
## * Fixed a problem when "yposition" is omitted.
## 
## 2007-11-16
## * derived from setElementsOnPlot

function elements_on_plot(names, lattice, varargin)
  [clear_flag, yposition] = get_properties(varargin, {"clear", "yposition"},...
                                                {false, "graph 0"});
  if (clear_flag)
    text();
  end
  
  if (ischar(yposition))
    [s, e, te, m, t, nm] = regexp(yposition, "(\\w+)\\s(-?\\d*)");
    if (s > 0)
      switch t{1}{1}
        case "first"
          yposition = str2num(t{1}{2});
        case "graph"
          yposition = str2num(t{1}{2});
          ca = gca();
          ylim = get(ca, "ylim");
          yposition = ylim(1) + (ylim(2) - ylim(1))*yposition;
        otherwise
          error("value of yposition is invalid.");
      endswitch
    else
      error("value of yposition is invalid.");
    endif
  endif
  
  for n = 1:length(lattice)
    for m = 1:length(names)
      if (regexp(lattice{n}.name, names{m}))
        #yposition
        text("Position", [lattice{n}.centerPosition, yposition] ...
          , "Rotation", 90 ...
          , "String", lattice{n}.name)
      endif
    endfor
  endfor
  
endfunction


