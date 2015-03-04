## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} plot_profile_csv(@var{arg})
##
## @end deftypefn

##== History
##

function plot_profile_csv(fname)
  data = load_profile_csv(fname);
  xyplot(data.h, "-@;Horizontal;", "linewidth", 2, ...
         data.v, "-@;Vertical;", "linewidth", 2);
  xlabel("[mm]"); grid on;
  aname = basename(fname, "\\.csv");
  atitle = [data.name, "-", aname];
  title(atitle);
  print("-dpdf", "-S7,5", "-F:10", [atitle, ".pdf"]);
endfunction

%!test
%! plot_profile_csv(x)
