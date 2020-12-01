## BM pattern of H+ 7MeV -> 120MeV 7120
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
 0	, 0.3039, "linear";
 35	, 0.3039, "spline";
 60	, 0.3138, "";
 85	, 0.3633, "linear";
 452.7	, 1.2369, "spline";
 477.7	, 1.2864, "";
 502.7	, 1.2963, "linear";
 1322.3	, 1.2963, "spline";
 1347.3	, 1.2864, "";
 1372.3	, 1.2369, "linear";
 1740	, 0.3633, "spline";
 1765	, 0.3138, "";
 1790	, 0.3039, "linear";
 2000	, 0.3039, 0};
  patternSet = build_pattern(pattern_cells);
endfunction
