## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} axis_inverter(@var{arg})
##
## @end deftypefn

##== History
##

function retval = axis_inverter(varargin)
  retval = struct("apply", @invert_axis, "kind", "Axis Inverter", "len", 0);
endfunction

%!test
%! axis_inverter(x)
