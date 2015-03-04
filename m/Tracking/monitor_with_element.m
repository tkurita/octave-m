## -*- texinfo -*-
## @deftypefn {Function File} {@var{monitor_rec} =} monitor_with_element(@var{element})
##
## @end deftypefn

##== History
## 2007-11-01
## * add "track_info_field"
## 
## 2007-10-03
## * initial implementaion

function monitor_rec = monitor_with_element(an_elem)
  monitor_rec.mat = mat_with_element(an_elem);
  monitor_rec.apply = @through_monitor;
  monitor_rec.name = an_elem.name;
  monitor_rec.track_info = "special";
endfunction

  