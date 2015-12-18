## BM pattern of H+ 7MeV -> 100MeV 7100
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
0,	0.3039, "linear";
35,	0.3039, "spline";
60,	0.3138, "";
85,	0.3633, "linear";
402.6,	1.118, "spline";
427.6,	1.1675, "";
452.6,	1.1774, "linear";
1372.4,	1.1774, "spline";
1397.4,	1.1675, "";
1422.4,	1.118, "linear";
1740,	0.3633, "spline";
1765,	0.3138, "";
1790,	0.3039, "linear";
2000,	0.3039, 0};
  
  patternSet = build_pattern(pattern_cells);
endfunction
