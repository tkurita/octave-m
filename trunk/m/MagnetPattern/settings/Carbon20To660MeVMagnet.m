## BM Pattern of C 8MeV -> 660MeV C001
1; # script file

function retval = BMPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
  {0, 0.2950, "linear" 
    35, 0.2950 ,"spline";
    60, 0.3049 ,"";
    85, 0.3540 ,"linear";
    640.2, 1.6642 ,"spline";
    665.2, 1.7134 ,"";
    690.2, 1.7232 ,"linear";
    1134.8, 1.7232 , 0};
  
  retval = build_pattern(pattern_cells);
endfunction

%!test
%! Carbon20To660MeVMagnet;plot_bpattern(BMPattern, "B")
