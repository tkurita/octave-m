# low_value = find_low(ylist, ["bin", bin, "threshold", threshold])
#
# ylist のベースラインを求める。
# ylist のヒストグラムを作成し、'threshold' 以上の度数の最初の y をベースラインとする。
# 
# - bin : ヒストグラムの総ビン数
# - threshold : 'threshold' 以上の最初のビンの値を 'low_value' とする。
#

function retval = find_low(ylist, varargin)
  [hbin, threshold] = get_properties(varargin, {"bin", "threshold"}, {200, 5});
  [yh, xh] = hist(ylist, hbin);
  bar(xh, yh);
  py = yh(1);
  start_ind  = 1;
  for n = 1:length(yh);
    if (yh(n) >=  threshold)
      start_ind = n;
      break;
    endif
  endfor
  
  [ym, yi] = max(yh >=  threshold);
  
  py = yh(yi);
  for n = yi:length(yh)
    if (yh(n) < py);
      yi = n-1;
      break;
    endif
    py = yh(n);
  endfor  
  retval = xh(yi);
  vline(retval);
endfunction