## -- retval = apply(tcic, inwave)
##     inwave に Tracking CIC を適用する
##
##  * Inputs *
##    tcic : Tracking CIC filter object
##    inwave : input data
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function outwave = apply(tcic, inwave)
  # 積分
  sig_after_intgl = filter(1, [1, -1], inwave);
  #size(sig_after_intgl)
  ce_idx = tcic.ce_idx;
  cem = tcic.cem;
  # CE シグナルで resampling
  #plot(t, sig_after_intgl, "-", t, inwave, "-");
  sig_after_resample = sig_after_intgl(ce_idx);
  #tce = t(ceidx);
  #plot(t, sig_after_intgl, "-", tce, sig_after_resample, "*");
  
  # comb フィルター適用
  sig_after_comb = filter([1, zeros(1, cem-1), -1], 1, sig_after_resample);
  
  # システムクロックで補間
  vout = zeros(1, length(inwave));
  preval = 0;
  preidx = 1;
  for n = 1:length(ce_idx)
    idx = ce_idx(n);
    vout(preidx:idx-1) = preval;
    preidx = idx;
    preval = sig_after_comb(n);
  endfor
  vout(preidx:end) = preval;
  #plot(sig_after_comb)
  #xlim([0,20]) # 1-13 の間、すなわち最初の 12 点は除去して振幅を計算する。
#  sig_after_comb(1:cem+1) = [];
#  amp = (max(sig_after_comb) + abs(min(sig_after_comb)))/2;
  # normalize
  outwave = vout*tcic.frev/tcic.fs;
endfunction
