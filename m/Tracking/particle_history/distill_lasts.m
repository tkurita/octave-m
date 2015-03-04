## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} distill_lasts(@var{particle_hist}, @var{min_turn}, @var{acceptance})
## 
## Horizontal の座標に条件を与えて、その条件を満たす最初の点の集合を求める。
## 
## @table @code
## @item @var{hist_array}
## distill_history の出力を与える。
##
## @item @var{min_turn}
## @var{min_turn} 回以上回ることが条件
##
## @item @var{acceptance}
## X座標の閾値か、平行四辺形のアクセプタンスを与える。
## NaN を与えると、NaN になる粒子を選別する。
##
## @end table
##
## @end deftypefn

##== History
## 2008-03-26
## * acceptance に [xmin, xmax] を与えられるようにした。
##
## 2008-03-25
## * NaN になる粒子を選別できるようにした。
##
## 2008-03-20
## * output に "n_rev" field を追加

function last_points = distill_lasts(a_hist, min_turn, acceptance)
  global __par__;

  if (isstruct(acceptance))
    xthreshold = acceptance.xmin;
    check_condition = @in_par;
    __par__ = acceptance;
  else
    if (length(acceptance) > 1)
      xthreshold = acceptance(1);
      check_condition = @return_true;
    else
      xthreshold = acceptance;
      check_condition = @return_true;
    end
  end
  
  last_points = struct("h", [], "v", [], "n_rev", [], "id", []);
  for n = 1:length(a_hist.h) # n is index of particles
    if (isnan(xthreshold))
      compare_result = isnan(a_hist.h{n}(:,1));
    else
      compare_result = a_hist.h{n}(:,1) > xthreshold;
      if (length(acceptance) > 1)
        compare_result = compare_result & (a_hist.h{n}(:,1) <= acceptance(2)) ;
      endif
    end

    if (any(compare_result))
      [max_val, max_ind] = max(compare_result);
      #if ((max_ind > 20) & is_in_parallerogram(para_shifted, a_hist.h{n}(max_ind,:), "h"))
      #if (max_ind > 20)
      if (max_ind >= min_turn)
        if (check_condition(a_hist.h{n}(max_ind,:)))
          last_points.h(end+1,:) = a_hist.h{n}(max_ind,:);
          last_points.v(end+1,:) = a_hist.v{n}(max_ind,:);
          last_points.n_rev(end+1) = max_ind;
          #last_points.id(end+1) = n;
          last_points.id(end+1) = a_hist.id(n);
        endif
      endif
    endif
  end
endfunction

function result = return_true(a_point)
  result = true;
endfunction

function result = in_par(a_point)
  global __par__
  result = is_in_parallerogram(__par__, a_point, "h");
end