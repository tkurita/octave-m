## BM pattern of H+ 8 -> 200MeV 8200
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
  0, 0.3274, "linear";
  35, 0.3274, "spline";
  60, 0.3373, "";
  85, 0.3868, "linear";
  615.5, 1.6473, "spline";
  640.5, 1.6968, "";
  665.5, 1.7067, "linear";
  1159.5, 1.7067,  "spline";
  1184.5, 1.6968,  "";
  1209.5, 1.6473,  "linear";
  1740, 0.3868,  "spline";
  1765, 0.3373,  "";
  1790, 0.3274,  "linear";
  2000, 0.3274,  0};
  
  patternSet = build_pattern(pattern_cells);  
endfunction

%!test
%! plotMagnetPattern(BMPattern, QFPattern, QDPattern, "B")
