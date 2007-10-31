
##== History
## 2007-10-03
## * initial implementaion

function monitor_rec = monitor_with_element(an_elem)
  monitor_rec.mat = mat_with_element(an_elem);
  monitor_rec.apply = @through_monitor;
  monitor_rec.name = an_elem.name;
endfunction

  