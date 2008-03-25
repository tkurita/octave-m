## distill_history(hist_at_elem, mode)
## 
## mode : 
##  * "surviving" : NaN にならない粒子だけ
##  * "strip NaN" : NaN 以降を削除
##  * omit : 何もしない。
## 
## result
##      .h : a cell array of which each cell is a hidtory of a particle.
##      .v  : 
##      .dp : 

##== History
## 2008-03-21
## * 劇的に高速化
## * matrix の結合は遅い
## * あらかじめ matrix を作って代入するのが高速
## 
## 2008-03-13
## * elem_name は必要ない。引数に与える時に particle_hist.(elem_name)とすればいい。
## * 各種モードを作った。
##
## 2008-03-06
## * .v をちゃんとした。
## * .dp を付け加えた。

## particle_hist の構造 -- 適切は function (track_ring)
## 
## 
function result = distill_history(hist_at_elem, filtering)
  # elem_name = "ESD";
  # horv = "h";
  # before_cell2mat = time()
  #a_mat = cell2mat(hist_at_elem');
  a_mat = arrange_cell(hist_at_elem);
  #after_cell2mat = time()
  # printf("time for cell2mat %d\n", after_cell2mat - before_cell2mat);
  ## 次のように整形される
  ## x11 , x21 ...
  ## y11 , y21 ...
  ## dp11, dp21 ...
  ## x'11, x'21 ...
  ## y'11, y'21 ...
  ## dp11, dp21 ...
  ## x12 , x22 ... <-- ここから 2turn目
  ## y12 , y22 ...
  ## dp12, dp22 ...
  ## x'12, x'22 ...
  ## y'12, y'22 ...
  ## dp12, dp22 ...
  nan_mat = isnan(a_mat);

  #  result.h = pick_history(a_mat, nan_cols, 1, 2);
  #  result.v = pick_history(a_mat, nan_cols, 4, 5);
  #  result.dp = pick_history(a_mat, nan_cols, 3, 3);
  #before_pick_history = time()
  result.h = pick_history(a_mat, 1, 2);
  result.v = pick_history(a_mat, 4, 5);
  result.dp = pick_history(a_mat, 3, 3);
  #after_pick_history = time()
  #printf("time for pick_history %d\n", after_pick_history - before_pick_history);

  if (nargin > 1)
    switch filtering
      case "surviving"
        result = pick_surviving(result, nan_mat);
      case "strip NaN"
        result = remove_nan_tails(result, nan_mat);
    endswitch
  end
endfunction

function a_hist = remove_nan_tails(a_hist, nan_mat)
  [max_val, max_ind] = max(nan_mat);
  max_ind = (max_ind - 1)/6;
  for [val, key] = a_hist
    for n = 1:length(max_ind)
      if (max_ind(n) > 0)
        val{n} = val{n}(1:max_ind(n), :);
      end
    end
    a_hist.(key) = val;
  end
end

function a_hist = pick_surviving(a_hist, nan_mat)
  # length of rows : 6*turns
  # length of columns : number of particles
  nan_cols = any(nan_mat, 1); # find columns which including NaN
                              # i.e. pick up particles going away
  for [val, key] = a_hist
    a_hist.(key) = val(!nan_cols);
  end                              
end

#function result = pick_history(a_mat, nan_cols, q_index, p_index)
#  nrows = rows(a_mat);
#  q_list = a_mat(q_index:6:nrows, !nan_cols);
#  nparticles = columns(q_list);
#  p_list = a_mat(p_index:6:nrows, !nan_cols);
#  nturns = nrows/6;
#  qp_mat = reshape([q_list; p_list], nturns, 2*nparticles);
#  result = mat2cell(qp_mat, [nturns], 2*ones(1,nparticles));
#endfunction

function result = pick_history(a_mat, q_index, p_index)
  nrows = rows(a_mat);
  ## x11 , x21 ...
  ## y11 , y21 ...
  ## dp11, dp21 ...
  ## x'11, x'21 ...
  ## y'11, y'21 ...
  ## dp11, dp21 ...
  ## x12 , x22 ... <-- ここから 2turn目
  ## y12 , y22 ...
  ## dp12, dp22 ...
  ## x'12, x'22 ...
  ## y'12, y'22 ...
  ## dp12, dp22 ...
  ##
  ## これを
  ## x11, x21 ...
  ## x12, x22 ...
  ## と
  ## x'11, x'21 ...
  ## x'12, x'22 ...
  ## に分割

  q_list = a_mat(q_index:6:nrows,:);
  nparticles = columns(q_list); # 列の数が粒子数
  p_list = a_mat(p_index:6:nrows,:);
  nturns = nrows/6;
  
  ## x11, x21 ...
  ## x12, x22 ...
  ## x'11, x'21 ...
  ## x'12, x'22 ...
  ## とくっつけてから
  ## 一つ目     二つ目
  ## x11, x'11, x21, x'21 ... -- 1turn目
  ## x12, x'12, x22, x'22 ... -- 2turn目
  ## と reshape
  qp_mat = reshape([q_list; p_list], nturns, 2*nparticles);

  ## {x11, x'11; x12, x'12; ...}, 
  ## {x21, x'21; x22, x'22; ...}
  ## とセルに分割 出来上がるのは row wise
  result = mat2cell(qp_mat, [nturns], 2*ones(1,nparticles));
endfunction

function out = arrange_cell(a_cell)
  out = zeros(6*length(a_cell), length(a_cell{1}));
  for n = 1:length(a_cell)
    ind = 1+6*(n-1);
    out(ind:ind+5,:) = a_cell{n};
  end
end