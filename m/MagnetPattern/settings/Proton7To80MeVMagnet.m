## BM pattern of H+ 7MeV -> 80MeV 7080
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
   0.0,  0.3039, "linear";
  35.0,  0.3039, "spline";
  60.0,  0.3138, "";
  85.0,  0.3633, "linear";
 348.1,  0.9884, "spline";
 373.1,  1.0379, "";
 398.1,  1.0478, "linear";
1426.9,  1.0478, "spline";
1451.9,  1.0379, "";
1476.9,  0.9884, "linear";
1740.0,  0.3633, "spline";
1765.0,  0.3138, "";
1790.0,  0.3039, "linear";
2000.0,  0.3039, 0};
  
  patternSet = build_pattern(pattern_cells);
endfunction
