## -*- texinfo -*-
## @deftypefn {Function File} {[@var{bl_interp}, @var{bclock_sum]=} spline_interp_bclock(@var{bclock_plus}, @var{block_minus}, @var{periods}, @var{t_interp}])
##
## Make summation of B-Clock data, and make a pttern with spline interpolcation.
##
## @strong{Inputs}
## @table @var
## @item bclock_plus
## An output of accumulate_bclock
## @item bclock_minus
## An output of accumulate_bclock
## @item periods
## Timmings to switch B-Clock ON/OFF in seconds.
## @item t_interp
## A list of times for interpolation.
## @end table
##
## @strong{Outputs}
## @table @var
## @item bl_interp
## BL pattern generated by interpolation.
## @item bclock_sum
## summation of @var{bclock_plus} and @var{bclock_minus}
## @end table
##
## @seealso{blpattern_with_bclock, merge_bclock}
## @end deftypefn

##== History
## 2013-08-22
## * initial implementaion.

function varargout = spline_interp_bclock(bclock_plus, bclock_minus, periods, t_interp)
  ## block_data : isf_data
  ## db : magnetic field differnece per on B Clock in [T*m]
  ## bl_fb : BL value at the flat base in [T*m]
  ## t_accstart : the timming of beginning of accerelation in seconds.
  ## t_accstop : the timming of end of accerelation in secconds.
  ## t_deaccstart : the timming of beginning of deaccerelation in secconds.
  ## periods (optional) : times to switch B-Clock ON/OFF
  ## interpolation (optional) : points for interpolation

  bclock_total = merge_bclock(bclock_plus, bclock_minus);
  t_list = bclock_total(:,1);
  bl_list = bclock_total(:,2);
  bl_interp = zeros(length(t_interp), 1);
  t_beg = 0;
  is_off = 1;
#  t_list = bclock_join(:,1);
#  bl_list = bclock_join(:,2) + bclock_join(:,3);
  #xyplot(t_list, bl_list)
  for t_end = periods
    #t_beg
    #t_end
    ind_t_in_period = find(t_list >= t_beg & t_list <= t_end);
    bl_in_period = bl_list(ind_t_in_period);
    if (! length(bl_in_period))
      bl_in_period = bl_list(t_list <= t_beg)(end);
    endif
    ind_t_targets = find(t_interp >= t_beg & t_interp < t_end);
    
    if is_off
      bl_interp(ind_t_targets) = bl_in_period(1);
    else
      #length(ind_t_in_period)
      t_in_period = [t_beg; t_list(ind_t_in_period); t_end];
      bl_in_period = [bl_list(ind_t_in_period(1)-1); 
                      bl_in_period; bl_list(ind_t_in_period(end))];
      t_interp_in_region = t_interp(ind_t_targets);
      bl_interp(ind_t_targets) = ppval(...
                splinecomplete(t_in_period, bl_in_period, [0,0]), ...
                 t_interp_in_region);
    endif
    
    t_beg = t_end;
    is_off = ! is_off;
  endfor

  varargout = {[t_interp(:), bl_interp], [t_list, bl_list]};
endfunction

%!test
%! interp_bclock(x)
