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
## 2007-11-16
## * derived from setElementsOnPlot

function elements_on_plot(names, lattice, varargin)
  n_options = length(varargin);
  n = 1;
  yposition = "graph 0";
  while (n_options >= n)
    option = varargin{n};
    switch (option)
      case ("clear")
        text();
      case ("yposition")
        yposition = varargin{n+1};
        y_pos = varargin{n+1};
        if (ischar(y_pos))
          [s, e, te, m, t, nm] = regexp(yposition, "(\\w+)\\s(\\d*)");
          if (s > 0)
            switch T{1}{1}
              case "first"
                yposition = str2num(T{1}{2});
              case "graph"
                yposition = str2num(T{1}{2});
                ca = gca();
                ylim = get(ca, "ylim")
                yposition = ylim(1) + (ylim(2) - ylim(1))*yposition;
              otherwise
                error("value of yposition is invalid.");
            endswitch
          else
            error("value of yposition is invalid.");
          endif
        endif
        n++;
      otherwise
        error("unknown option is given in arguments.");
    endswitch
    n++;
  endwhile
   
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
          , "String", lattice{n}.name);
      endif
    endfor
  endfor
  
endfunction


