## BM pattern of H+ 7MeV -> 50MeV 7050
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
0,	0.3039, "linear";
35,	0.3039, "spline";
60,	0.3138, "";
85,	0.3633, "linear";
253,	0.7626, "spline";
278,	0.8121, "";
303,	0.822, "linear";
1522,	0.822, "spline";
1547,	0.8121, "";
1572,	0.7626, "linear";
1740,	0.3633, "spline";
1765,	0.3138, "";
1790,	0.3039, "linear";
2000,	0.3039, 0};
  
  patternSet = build_pattern(pattern_cells);
endfunction
