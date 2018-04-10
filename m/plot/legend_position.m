## -*- texinfo -*-
## @deftypefn {Function File} {@var{position} =} legend_position
## Obtain current position of legend.
##
## @deftypefnx {Function File} {} legend_position(@var{dx}, @var{dy})
## Shift position of legend with @var{dx} and @var{dy}.
##
## @end deftypefn

function retval = legend_position(dx, dy)
    [HLEG, HLEG_OBJ, HPLOT, LABELS] = legend;
    pos = get(HLEG, "position");
  if (! nargin) 
    #if (nargout < 1)
#      print_usage();
#      return
#    else
      retval = pos;
      return;
    #end
  end
  pos(1) += dx;
  pos(2) += dy;
  pos(3) += dx;
  pos(4) += dy;
  set(HLEG, "position", pos);
end

%!test
%! func_name(x)
