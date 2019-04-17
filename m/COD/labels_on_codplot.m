## -- labels_on_codplot() 
##   place labels of BPMs and magnet on COD plot.
##
## labels_on_codplot("lattice", lattice) # set lattice. 
## # lattice is cod object or lattice struct
##
## labels_on_codplot("BPM_labels", {"^BPM3", "^BPM6", "^PR1","^PR2"})
## # The default value is {"^BPM\\d"}
##
## labels_on_codplot("magnet_labels", {"BM\\d", "QF", "QD", "STH", "STV"}
## # The default value is  {"BM\\d", "QF", "QD"}
##
## labels_on_codplot()
##  # or
## labels_on_codplot("BPMs", "graph 0.1", "magnets", "first -5")
## # spedify label position

function labels_on_codplot(varargin)
  persistent lattice = NA;
  persistent BPM_labels = {"^BPM\\d"};
  persistent magnet_labels =  {"BM\\d", "QF", "QD"};
  persistent position = {"graph 0.1", "first -5"}; # graph for BPMs, first for magnets

  do_plot = false;
  
  if length(varargin) < 1
    do_plot = true;
  endif

  argidx = 1;
  while(length(varargin) > argidx) 
    switch varargin{argidx}
      case "lattice"
        lattice = varargin{argidx+1};
      case "BPM_labels"
        BPM_labels = varargin{argidx+1};
      case "magnet_labels"
        magnet_labels = varargin{argidx+1};
      case "position"
        position = varargin{argidx+1};
      case {"BPMs", "magnets"}
        varargin = varargin(argidx:end);
        do_plot = true;
        break;
      otherwise
        error([varargin{argidx}, " is unknown parameter name."]);
    endswitch
    argidx += 2;
  endwhile
  
  if !do_plot
    return
  endif

  opts = get_properties(varargin, {"BPMs", "magnets"}, position);
  xlabel("position [m]");ylabel("COD [mm]");grid on;
  if strcmp("cod", class(lattice))
    lattice = lattice.ring;
  endif
  elements_on_plot(magnet_labels, lattice,...
                "clear", "yposition", opts.magnets);
  elements_on_plot(BPM_labels, ...
                    lattice, "yposition", opts.BPMs);
endfunction
