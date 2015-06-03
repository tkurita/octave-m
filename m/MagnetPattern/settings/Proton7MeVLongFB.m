## BM pattern of H+ 7MeV Long Flat Base T037
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
    0.0, 0.3040, "linear";
    385.0, 0.3040, "spline";
    410.0, 0.3081, "";
    435.0, 0.3282, "linear";
    949.2, 0.8258, "spline";
    974.2, 0.8459, "";
    999.2, 0.8500, "linear";
    1175.8, 0.8500, "spline";
    1200.8, 0.8459, "";
    1225.8, 0.8258, "linear";
    1740.0, 0.3282, "spline";
    1765.0, 0.3081, "";
    1790.0, 0.3040, "";
    2000.0, 0.3040, 0 };
  
  patternSet = build_pattern(pattern_cells);
endfunction
