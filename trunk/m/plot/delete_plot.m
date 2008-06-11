## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} delete_plot(@var{arg})
##
## @end deftypefn

##== History
##

function delete_plot(ind)
  if (nargin < 1)
    ind = length(get(gca, "children"));
  endif
  delete(get(gca, "children")(ind));
  set(gcf, "__modified__", true);
endfunction