## -*- texinfo -*-
## @deftypefn {Function File} {@var{tzc} =} zero_crossing(@var{XY}, ["threshold", @var{threshold}, "edge", @var{edge})
## obtain zero crossing timings from oscillating signal.
##
## @strong{Inputs}
## @table @var
## @item xy
## column wise two dimensional matrix
## @end table
##
## @strong{Options}
## @table @code
## @item threshold
## pass 2 for low sampling rate or 5 for high sampling rate.
## The default value is 5.
## @item edge
## "falling" or "raising". The default is "falling"
## @end table
##
## @end deftypefn

##== History
## 2014-04-16
## * first implemantation

function xzc = zero_crossing(xy, varargin)
  if ! nargin
    print_usage();
  endif
  diff_threshold = 5;
  [diff_threshold, edge, plot_flag] = get_properties(varargin,
                                  {"threshold", "edge", "plot"},
                                  {5, "falling", false});  
  positive_indexes = find(xy(:,2) > 0);
  indexes_diff = diff(positive_indexes);
  
  falling_positions = indexes_diff > diff_threshold;
  switch edge
    case "falling"
      #disp "falling"
      ind_list = find(falling_positions);
      zc_indexes1 = positive_indexes(ind_list);
      xzc = x_at_zerocrossing(xy, zc_indexes1, zc_indexes1 +1);
    otherwise # raising
      #disp "raising"
      raising_positions = [0; falling_positions(1:end-1)];
      ind_list = find(raising_positions);
      zc_indexes1 = positive_indexes(ind_list);
      xzc = x_at_zerocrossing(xy, zc_indexes1, zc_indexes1 -1);
  endswitch

  if plot_flag
    yzc = interp1(xy(:,1), xy(:,2), xzc);
    xyplot(xy, "-", [xzc(:), yzc(:)], "*")
  endif
endfunction

function xzc = x_at_zerocrossing(xy, zc_indexes1, zc_indexes2)
  y1 = xy(zc_indexes1, 2);
  y2 = xy(zc_indexes2, 2);
  zc_indexes0 = (y1.*zc_indexes2 - y2.*zc_indexes1)./(y1 - y2);
  zc_indexes0_floor = floor(zc_indexes0);
  x1 = xy(zc_indexes0_floor, 1);
  x2 = xy(ceil(zc_indexes0), 1);
  xzc = x1 + (zc_indexes0 - zc_indexes0_floor).*(x2 -x1);
endfunction

%!test
%! func_name(x)
