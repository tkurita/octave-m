## BM Pattern of C 20MeV -> 660MeV C001
1; # script file

function retval = BMPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
      {0.0,0.2950, "linear";
      35.0,0.2950, "spline";
      60.0,0.3049, "";
      85.0,0.3540, "linear";
      640.2,1.6642, "spline";
      665.2,1.7134, "";
      690.2,1.7232, "linear";
      1134.8,1.7232, "spline";
      1159.8,1.7134, "";
      1184.8,1.6642, "linear";
      1740.0,0.3540, "spline";
      1765.0,0.3049, "";
      1790.0,0.2950, "linear";
      2000.0,0.2950, 0};
  retval = build_pattern(pattern_cells);
endfunction

function retval = QFPattern
  pattern_cells = {...
    0.0,0.0946, "linear";
    35.0,0.0946, "spline";
    60.0,0.0977, "";
    85.0,0.1135, "linear";
    640.2,0.5324, "spline";
    665.2,0.5482, "";
    690.2,0.5513, "spline";
    702.7,0.5504, "";
    727.7,0.5420, "";
    740.2,0.5411, "linear";
    1084.8,0.5411, "spline";
    1097.3,0.5420, "";
    1122.3,0.5504, "";
    1134.8,0.5513, "spline";
    1159.8,0.5482, "";
    1184.8,0.5324, "linear";
    1740.0,0.1135, "spline";
    1765.0,0.0977, "";
    1790.0,0.0946, "linear";
    2000.0,0.0946, 0};
  retval = build_pattern(pattern_cells);
endfunction

function retval = QDPattern
  pattern_cells = {...
    0.0, 0.1012, "linear";
    41.0, 0.1012, "spline";
    68.0, 0.1048, "";
    95.0, 0.1232, "linear";
    640.2, 0.5692, "spline";
    665.2, 0.5863, "";
    690.2, 0.5897, "linear";
    1134.8, 0.5897, "spline";
    1159.8, 0.5863, "";
    1184.8, 0.5692, "linear";
    1740.0, 0.1232, "spline";
    1765.0, 0.1048, "";
    1790.0, 0.1012, "linear";
    2000.0, 0.1012, 0};

  retval = build_pattern(pattern_cells);
endfunction

%!test
%! Carbon20To660MeVMagnet;
%! plot_bpattern(BMPattern, QFPattern, QDPattern, "B")
