## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} fit_coodinates(@var{src_points}, @var)
## src_points を target_points に適合させる平行移動量と回転角を求める。
## 
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
## 2012-02-27
## * 最初の実装
## * leasqr の x と y は 2次元行列でも受け付けるようだ。
## * でも、verbose = 1 の時はエラーがでる。
##   すなわち、2次元データのプロットは考慮していない。
## * 動作するのは、たまたまの可能性があるので、
##   src_points と target points を1次元 matrix に変換してから処理


function retval = fit_coordinate(src_points, target_points, pin)
  stol=0.01; 
  #stol=0.0001; 
  niter=5;
  global verbose;
  verbose=1;
  p_src = flatten(src_points);
  p_target = flatten(target_points);
  [f1, leasqr_results, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr(p_src, p_target, pin, @connect_coordinate)
  retval = struct("cos_theta", leasqr_results(1), ...
                   "dxdy", leasqr_results(2:3)');
endfunction

function retval = connect_coordinate(p_src, p)
  p_src = unflatten(p_src, 2);
  cos_theta = p(1);
  if abs(p(1)) > 1
    cos_theta = 1
  end
  dxdy = [p(2), p(3)];
  
  nrows = rows(p_src);
  ## 平行移動
  p_src_shifted = p_src + repmat(dxdy, nrows, 1);

  ## 最初の点を原点に移動
  move_to_origin_mat = repmat(p_src_shifted(1, :), nrows, 1);
  p_src_shifted2 = p_src_shifted - move_to_origin_mat;
  
  ## 回転
  sin_theta = sqrt(1-cos_theta^2);
  cw_mat = [cos_theta, sin_theta; -sin_theta, cos_theta];
  p_target = transpose(cw_mat * p_src_shifted2') + move_to_origin_mat;
  retval = flatten(p_target);
endfunction

function retval = flatten(mat)
  s = size(mat);
  row_max = s(1)*s(2);
  retval = reshape(mat, row_max, 1);
endfunction

function retval = unflatten(mat, ncol)
  row_max = length(mat)/ncol;
  retval = reshape(mat, row_max, ncol);
endfunction


%!test
%! func_name(x)
