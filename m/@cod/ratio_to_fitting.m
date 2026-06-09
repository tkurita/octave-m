## -- retval = ratio_to_fitting(cod_bpms, cod_fit)
##     計算値に対して、実際に発生した COD の割合を求める。
##     cod_fit で計算された COD に対する、cod_bpms.at_bpms の割合を計算する
##     cod_bpms は、補正適用前後の差分を与える。
##     この結果を見て current_factor を修正する
##
##  * Inputs *
##    arg1 : 
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##      cod_fit = fit(cod_fit);
##      displacement_cod = subtract(bpms_after, cod_fit);
##      ratio_to_fitting(displacement_cod, cod_fit);
##      
##  See also: 

function retval = ratio_to_fitting(cod_bpms, cod_fit)
  if ! nargin
    print_usage();
    return;
  endif
  xy = by_kickers(cod_fit);
  measurement = struct();
  fitting = struct();
  ratio = struct();
  ratio_list = [];
  for [val, key] = cod_bpms.at_bpms
    x = element_with_name(cod_fit.ring, key).centerPosition;
    y = xy_near_x(xy, x)(2);
    r = val/y;
    ratio.(key) = r;
    measurement.(key) = val;
    fitting.(key) = y;
    ratio_list(end+1) = r;
  endfor
  retval.mean = mean(ratio_list);
  retval.measurement = measurement;
  retval.fitting = fitting;
  retval.ratio = ratio;
  printf("%5s\t%s\t%s\t%s\n", "Name", "Ratio", "Measure", "Fit");
  for [val, key] = ratio
    printf("%5s\t% .3f\t% .3f\t% .3f\n", key, val, measurement.(key), fitting.(key));
  endfor
  printf("%5s\t% .3f\n", "Mean", retval.mean)
endfunction

%!test
%! func_name(x)
