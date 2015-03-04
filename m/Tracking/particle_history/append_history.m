## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @table @code
## @item @var{particle_hist}
## The output of distill_history
##
## @end table
## @end deftypefn

##== History
## 2008-03-26
## * initial implementaion

function particle_hist = append_history(particle_hist, hist_at_element)
  a_hist = distill_history(hist_at_element);
  for [val, key] = particle_hist
    if (iscell(val))
      for n = 1:length(val)
        particle_hist.(key){n} = cat(1, particle_hist.(key){n}...
                                        , a_hist.(key){n});
      endfor
    endif
  endfor
  
endfunction