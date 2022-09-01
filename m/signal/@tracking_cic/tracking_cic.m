## -- tcic = tracking_cic(frev, fs, cem, ts)
##     tracing cic のシミュレーション
##     CE パルスでリサンプルされた出力はシステムクロックで補間する。
##
##  * Inputs *
##    frev : frequency of first notch in Hz
##    fs : frequency of system clock
##    cem : multipulication number and delay of clock enable pulse
##    ts : サンプリングする時間の配列 0:1/fs:tmax (処理する最大時間)
##
##  * Outputs *
##    Instance of Tracking CIC filtter object.
##    
##  * Exmaple *
##
##  See also: 

function tcic = tracking_cic(frev, fs, cem, ts)
  # CE pulse の計算
  cewave = sin(2*pi*frev*cem*ts);
  idx_p = find(cewave > 0);
  diff_idx_p = diff(idx_p);
  idx_diff = find(diff_idx_p > 1);
  ce_idx = idx_p(idx_diff+1);
  
  if mod(ts(end)-ts(1), 1/(frev*cem)) == 0
    ce_idx(end+1) = length(ts);
  endif
  
  retval = struct("frev", frev, "fs", fs, "cem", cem ...
                , "ts", ts, "ce_idx", ce_idx, "opts", NA);
  tcic = class(retval, "tracking_cic");
endfunction

# demo @tracking_cic/tracking_cic

%!demo
%! frev = 9.3762e+05;
%! fs = 150e6;
%! cem = 12;
%! tmax = 50/frev;
%! ts = 0:1/fs:tmax;
%! f = frev/2;
%! inwave = sin(2*pi*f*ts);
%! inwave_rev = sin(2*pi*frev*ts);
%! tcic = tracking_cic(frev, fs, cem, ts);
%! outwave = apply(tcic, inwave);
%! outwave_rev = apply(tcic, inwave_rev);
%! plot(ts, outwave, sprintf("-;%f;", f) ...
%!    , ts, outwave_rev, sprintf("-;%f;", frev))

%!test
%! func_name(x)
