## BM pattern of H+ 9MeV -> 200MeV 9200
1; #script file

#function timeSet = timeRegion
#  timeSet.capture = [0,35];
#  timeSet.initialAcc = [35,60,85];
#  timeSet.acc = [85, 607.1];
#  timeSet.postAcc = [607.1, 632.1, 657.1];
#  timeSet.flatTop = [657.1, 1167.9];
#  timeSet.preExt = [657.1, 669.6, 694.6, 707.1];
#  timeSet.extract = [707.1, 1117.9];
#endfunction

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
  {0, 0.1113, "linear" ;
  35, 0.1113, "spline" ;
  60, 0.1146, "" ;
  85, 0.1310, "linear" ;
  607.1 , 0.5437, "spline";
  632.1 , 0.5602, "";
  657.1 , 0.5635, "spline";
  669.6 , 0.5620, "" ;
  694.6 , 0.5465, "" ;
  707.1 , 0.5449, 0};
  
  patternSet = build_pattern(pattern_cells);

endfunction

function patternSet = QDPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
  {0, 0.1190, "linear" ;
  37, 0.1190, "spline" ;
  64    , 0.1223, "" ;
  91    , 0.1388, "linear" ;
  607.1 , 0.5531, "spline" ;
  632.1 , 0.5696, "" ;
  657.1 , 0.5729, 0};

  patternSet = build_pattern(pattern_cells);
endfunction

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {\
  0    , 0.3473, "linear";
  35   , 0.3473, "spline";
  60   , 0.3572, "";
  85   , 0.4067, "linear";
  607.1, 1.6473, "spline";
  632.1, 1.6968, "";
  657.1, 1.7067, 0};
  
  patternSet = build_pattern(pattern_cells);  
endfunction

%!test
%! plotMagnetPattern(BMPattern, QFPattern, QDPattern, "B")
