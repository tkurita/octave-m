## BM pattern of He 10MeV -> 200MeV He02
1; #script file

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
  {0      ,0.1173 , "linear" ;
   35     ,0.1173 , "spline" ;
   60     ,0.1204 , "" ;
   85     ,0.1357 , "linear" ;
   625.4  ,0.5339 , "spline";
   650.4  ,0.5492 , "";
   675.4  ,0.5523 , "spline";
   687.9  ,0.5514 , "" ;
   712.9  ,0.5428 , "" ;
   725.4  ,0.5419 , "linear";
   1099.6 ,0.5419 , 0};
  
  patternSet = build_pattern(pattern_cells);
endfunction

function patternSet = QDPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
   {0     , 0.1254 , "linear" ;
    40    , 0.1254 , "spline" ;
    65    , 0.1287 , "" ;
    90    , 0.1453 , "linear" ;
    625.4 , 0.5706 , "spline" ;
    650.4 , 0.5872 , "" ;
    675.4 , 0.5905 , "linear";
    1149.6, 0.5905 , 0};
  
  patternSet = build_pattern(pattern_cells);
endfunction

function patternSet = BMPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
  {\
    0     , 0.3662  , "linear";
    35    , 0.3662 , "spline";
    60    , 0.3758 , "";
    85    , 0.4238 , "linear";
    625.4 , 1.6682 , "spline";
    650.4 , 1.7162 , "";
    675.4 , 1.7258 , "linear";
    1149.6, 1.7258 , 0 };
  
  patternSet = build_pattern(pattern_cells);  
endfunction

%!test
%! He10To200MeVMagnet;plot_bpattern(BMPattern, QFPattern, QDPattern, "B")
