## BM pattern of H+ 7MeV -> 140MeV 7140
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
 0	, 0.3039, "linear";
 35	, 0.3039, "spline";
 60	, 0.3138, "";
 85	, 0.3633, "linear";
 499.4	, 1.3478, "spline";
 524.4	, 1.3973, "";
 549.4	, 1.4072, "linear";
 1275.6	, 1.4072, "spline";
 1300.6	, 1.3973, "";
 1325.6	, 1.3478, "linear";
 1740	, 0.3633, "spline";
 1765	, 0.3138, "";
 1790	, 0.3039, "linear";
 2000	, 0.3039, 0};
  patternSet = build_pattern(pattern_cells);
endfunction
