## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function p = calib_channel_to_position(calib_table, lat_rec)
  x = []; y=[];
  for n = 1:length(calib_table)
    name = calib_table{n}{1};
    x(end+1) = calib_table{n}{3};
    elem = element_with_name(lat_rec, name);
    y(end+1) = elem.([calib_table{n}{2},"Position"]);
  end
  
  plot(x, y,"@", "markersize", 2);xlabel("Channel");ylabel("Position");
  p = polyfit(x, y, 1);
  hold on;
  fplot(polyout(p), xlim())
  hold off;
endfunction
