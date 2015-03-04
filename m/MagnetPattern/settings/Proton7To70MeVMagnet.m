## BM pattern of H+ 7MeV -> 70MeV 7070
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
       0	, 0.3039, "linear";
      35	, 0.3039, "spline";
      60	, 0.3138, "";
      85	, 0.3633, "linear";
     318.5	, 0.9182, "spline";
     343.5	, 0.9677, "";
     368.5	, 0.9776, "linear";
    1456.5	, 0.9776, "spline";
    1481.5	, 0.9677, "";
    1506.5	, 0.9182, "linear";
    1740	, 0.3633, "spline";
    1765	, 0.3138, "";
    1790	, 0.3039, "linear";
    2000	, 0.3039, 0};
  
  patternSet = build_pattern(pattern_cells);
endfunction
