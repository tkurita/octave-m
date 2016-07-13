## BM pattern of H+ 10MeV -> 100MeV 0100
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
      0	,0.3662, "linear";
      35	,0.3662, "spline";
      60	,0.376, "";
      85	,0.4252, "linear";
      378.8	,1.1184, "spline";
      403.8	,1.1676, "";
      428.8	,1.1774, "linear";
      1396.2	,1.1774, "spline";
      1421.2	,1.1676, "";
      1446.2	,1.1184, "linear";
      1740	,0.4252, "spline";
      1765	,0.376, "";
      1790	,0.3662, "linear";
      2000	,0.3662, 0};
  patternSet = build_pattern(pattern_cells);  
endfunction
