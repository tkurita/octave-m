## Usage : elements_on_plot(names, lattice, "property", value...)
##
## show element nemas in lattice on plot
## 
## = Parameters
## * names (cell array) -- cell array of strins
##                         show elements of which name starts with strings in names
## * lattice (cell array)
## 
## * property
##   "clear" -- clear text on plot before making new text on plot. no value
##   "yposition" -- vertical position of element names
##                  value is string or nunber.
##                  ex)
##                  "graph 0"
##                  "first 0"
##                  0 -- it mean "first 0"

##= History
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
      findAns = findstr(lattice{n}.name, names{m}, 0);
      if (length(findAns) && findAns(1)==1)
        #eval(sprintf("__gnuplot_set__ label \"%s\" at %f,graph 0 rotate by 90 font \"Helvetica,10\""...
        #eval(sprintf("__gnuplot_raw__(\"set label \\\"%s\\\" at %f,%s rotate by 90;\");",...
        #                          lattice{n}.name, lattice{n}.centerPosition, yposition));
        #text(lattice{n}.centerPosition, yposition, lattice{n}.name\
        #, "Rotation", 90, "FontName", "Helvetica", "FontSize", 10);
        #text(lattice{n}.centerPosition, yposition, lattice{n}.name\
        #  , "Rotation", 90, "FontName", "Helvetica");
        text("Position", [lattice{n}.centerPosition, yposition]\
          , "Rotation", 90\
          , "String", lattice{n}.name)
      endif
    endfor
  endfor
  
endfunction


