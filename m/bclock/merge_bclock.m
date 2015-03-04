## -*- texinfo -*-
## @deftypefn {Function File} {@var{bclock_total} =} merge_bclock(@var{blcock_plus}, @var{bclock_minus})
## merge @var{blcock_plus}, @var{bclock_minus}.
## @strong{Inputs}
## @table @var
## @item bclock_plus
## should be output of accumulate_bclock
## @item bclock_minus
## should be  bclock_minus
## @end table
##
## @seealso{interp_bclock, accumulate_bclock} 
## @end deftypefn

##== History
## 2013-09-27
## * first implementaion

function bclock_total = merge_bclock(bclock_plus, bclock_minus)
  bclock_minus = [bclock_minus(:,1), zeros(rows(bclock_minus), 1),...
                  bclock_minus(:,2), ones(rows(bclock_minus), 1)];
  bclock_plus = [bclock_plus(:,1), bclock_plus(:,2),...
                zeros(rows(bclock_plus),1), zeros(rows(bclock_plus), 1)];
  bclock_join = [bclock_plus(1:end-1,:); bclock_minus(2:end,:)];
  bclock_join = sortrows(bclock_join, 1);
  # 1 : time
  # 2 : bl by b-clock+
  # 3 : bl by b-clock-
  # 4 : flag of b-clock-
  indexes_minus = find(bclock_join(:,3));
  bplus = 0;
  n_minustotal = rows(indexes_minus);
  n_join = rows(bclock_join);
  for n = 1:length(indexes_minus)
    ind = indexes_minus(n);
    if (! bclock_join(ind-1 , 4)) # previous index is b-clock plus
      bplus = bclock_join(ind-1 , 2);
    endif
    bminus = bclock_join(ind, 3);
    bclock_join(ind, 2) = bplus;
    if (n < n_minustotal)
      ind_next = indexes_minus(n+1);
      if (ind_next - ind) > 1
        bclock_join(ind+1:ind_next-1, 3) = bminus;
      endif
    else
      if (n_join - ind) >= 1
        bclock_join(ind+1:n_join, 3) = bminus;
      endif
    endif
  endfor
  
  bclock_total = [bclock_join(:,1), bclock_join(:,2) + bclock_join(:,3)];
endfunction

%!test
%! func_name(x)
