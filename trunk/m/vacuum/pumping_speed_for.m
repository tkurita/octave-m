## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function retval = pumping_speed_for(elem)
  pumps = pump_info(-0.875);
  retval = 0;
  for n = 1:rows(pumps)
    if (elem.entrancePosition <= pumps{n,2}) ...
        && (pumps{n,2} <= elem.exitPosition)
      retval = retval + pumps{n,3};
    endif
  endfor
endfunction

%!test
%! func_name(x)
