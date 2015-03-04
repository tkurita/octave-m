## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} history_for_id(@var{monitor_history}, @var{id}, @var{horv})
##
## @table @code
## @item @var{monitor_history}
## Output of distill_history
##
## @item @var{id}
## id of the particle to obtain
##
## @item @var{horv}
## Horizontal "h" or vertical "v". 
## @end table
##
## @end deftypefn

##== History
## 2008-05-27
## * first implementation

function retval = history_for_id(monitor_hist, id, horv)
  ind = find(monitor_hist.id == id)
  retval = monitor_hist.(horv){ind};
endfunction