## BM pattern of H+ 7MeV -> 160MeV 7160
1; #script file

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
       0	, 0.3039, "linear";
      35	, 0.3039, "spline";
      60	, 0.3138, "";
      85	, 0.3633, "linear";
     543.4	, 1.4524, "spline";
     568.4	, 1.5019, "";
     593.4	, 1.5118, "linear";
    1231.6	, 1.5118, "spline";
    1256.6	, 1.5019, "";
    1281.6	, 1.4524, "linear";
    1740	, 0.3633, "spline";
    1765	, 0.3138, "";
    1790	, 0.3039, "linear";
    2000	, 0.3039, 0};
  patternSet = build_pattern(pattern_cells);
endfunction
