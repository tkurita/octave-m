## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} shift_figure(@var{offset})
## 
## Add @var{offset} to all of data in the current figure.
##
## @var{offset} is a vector of [x, y] or [x, y, z];
##
## @end deftypefn

##== History
## 2008-09-26
## * first implementation

function shift_figure(offset)
  #offset = [0, offset];
  children = get(gca, "children");
  data_labels = {"xdata", "ydata", "zdata"};
  for m = 1:length(children)
    for k = 1:length(offset)
      data = get(children(m), data_labels{k});
      set(children(m), data_labels{k}, data + offset(k))
    endfor
  endfor
endfunction

%!test
%! shift_figure(x)
