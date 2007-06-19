## Usage : setElementsOnPot(names, lattice, "property", value...)
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
##                  "second 0"
##                  0 -- it mean "first 0"


function setElementsOnPlot(names, lattice, varargin)
  n_options = length(varargin);
  n = 1;
  yposition = "graph 0";
  while (n_options >= n)
    option = varargin{n};
    switch (option)
      case ("clear")
        text();
      case ("yposition")
        y_pos = varargin{n+1};
        if (ischar(y_pos))
          yposition = y_pos;
        elseif (isscalar(y_pos))
          yposition = sprintf("graph %f", y_pos);
        else
          error("value of yposition is invalid.");
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
        eval(sprintf("__gnuplot_raw__(\"set label \\\"%s\\\" at %f,%s rotate by 90;\");", lattice{n}.name, lattice{n}.centerPosition, yposition));
        #text(lattice{n}.centerPosition, yposition, lattice{n}.name\
        #, "Rotation", 90, "FontName", "Helvetica", "FontSize", 10);
        #text(lattice{n}.centerPosition, yposition, lattice{n}.name\
        #  , "Rotation", 90, "FontName", "Helvetica");
        
      endif
    endfor
  endfor
  
  if (automatic_replot)
    replot;
  endif
  
endfunction


