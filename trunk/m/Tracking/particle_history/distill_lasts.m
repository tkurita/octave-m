## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} distill_lasts(@var{hist_array})
## 
## Horizontal の座標に条件を与えて、その条件を満たす最初の点の集合を求める。
## 
## @table @code
## @item @var{hist_array}
## distill_history の出力を与える。
## @item @var{min_turn}
## @var{min_turn} 回以上回ることが条件
## @item @var{acceptance}
## x 座標の閾値か、平行四辺形のアクセプタンスを与える。
## @end table
##
## @end deftypefn

##== History
##

function last_points = distill_lasts(a_hist, min_turn, acceptance)
  global __par__;

  if (isstruct(acceptance))
    xthreshold = acceptance.xmin;
    check_condition = @in_par;
    __par__ = acceptance;
  else
    xthreshold = acceptance;
    check_condition = @return_true;
  end
  
  last_points = struct("h", [], "v", []);
  for n = 1:length(a_hist.h)
    [max_val, max_ind] = max(a_hist.h{n}(:,1) > xthreshold);
    #if ((max_ind > 20) & is_in_parallerogram(para_shifted, a_hist.h{n}(max_ind,:), "h"))
    #if (max_ind > 20)
    if (max_ind >= min_turn)
      if (check_condition(a_hist.h{n}(max_ind,:)))
        last_points.h(end+1,:) = a_hist.h{n}(max_ind,:);
        last_points.v(end+1,:) = a_hist.v{n}(max_ind,:);
      end
    end
  end
endfunction

function result = return_true(a_point)
  result = true;
endfunction

function result = in_par(a_point)
  global __par__
  result = is_in_parallerogram(__par__, a_point, "h");
end