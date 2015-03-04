## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function varargout = pos_ch_table(calib_table, lat_rec)
  x = []; y=[];
  for n = 1:length(calib_table)
    name = calib_table{n}{1};
    x(end+1) = calib_table{n}{3};
    elem = element_with_name(lat_rec, name);
    y(end+1) = elem.([calib_table{n}{2},"Position"]);
  end
  if (nargout < 2) 
    varargout = {[x',y']};
  else
    varargout = {x',y'};
  end
endfunction
