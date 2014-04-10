## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} scale_label_offset(@var{h}, @var{v})
## Adjust label offset by scaling.
## Must be called after settings of xlim and ylim.
##
## @strong{Inputs}
## @table @var
## @item h
## graphic handle of a text
## @item v
## a vector of scale factor [x, y, z]
## @end table
##
## @end deftypefn

##== History
## 2014-04-10
## * first implementation

function h = scale_label_offset(h, v)
  if ! nargin
    print_usage();
  endif
  
  current_pos = get(h, "position");
  ax = get(h, "parent");
  xl = get(ax, "xlim");
  yl = get(ax, "ylim");
  zl = get(ax, "zlim");
  origin = [xl(1), yl(1), zl(1)];
  ofs = (current_pos - origin).*v;
  set(h, "position", ofs + origin);
endfunction

%!test
%! scale_label_offset(x)
