## BM pattern of H+ 10MeV -> 80MeV 0080
1; #script file

##== Hisotory
## 2014-10-15
## * first

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
      0.0	, 0.3662, "linear";
      35.0	, 0.3662, "spline";
      60.0	, 0.3761, "";
      85.0	, 0.4256, "linear";
      321.8	, 0.9884, "spline";
      346.8	, 1.0379, "";
      371.8	, 1.0478, "linear";
      1453.2	, 1.0478, "spline";
      1478.2	, 1.0379, "";
      1503.2	, 0.9884, "linear";
      1740.0	, 0.4256, "spline";
      1765.0	, 0.3761, "";
      1790.0	, 0.3662, "linear";
      2000.0	, 0.3662, 0};
  patternSet = build_pattern(pattern_cells);  
endfunction