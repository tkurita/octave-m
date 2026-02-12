function setup_codplot_labels(lattice, visible_labels, varargin)
  opts = get_properties(varargin, {"BPMs", "magnets"}, {0.1, -5});
  xlabel("position [m]");ylabel("COD [mm]");grid on;
  if strcmp("cod", class(lattice))
    lattice = lattice.ring;
  endif
  elements_on_plot(visible_labels, lattice,...
                "clear", "yposition", sprintf("first %f", opts.magnets));
  if ! isna(opts.BPMs)
    elements_on_plot({"^BPM3", "^BPM6", "^PR1","^PR2"}, ...
                     lattice, "yposition", sprintf("graph %f", opts.BPMs));
  endif
endfunction
