## BM pattern of H+ 7MeV -> 200MeV
1; #script file

function timeSet = timeRegion
  timeSet.capture = [0,35];
  timeSet.initialAcc = [35,60,85];
  timeSet.acc = [85, 625.4];
  timeSet.postAcc = [625.4, 650.4, 675.4];
  timeSet.flatTop = [675.4, 1149.6];
  timeSet.preExt = [675.4, 687.9, 712.9, 725.4];
  timeSet.extract = [725.4, 1099.6];
endfunction

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##== capture period
  region1 = makeRegion(timeSet.capture, [0.0973, 0.0973],"linear");
  
  ##== initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.0973, 0.1005, 0.117], "spline");
  
  ##== acceleration period
  region3 = makeRegion(timeSet.acc, [0.117, 0.5437], "linear");
  
  region2 = setSplineGrad(region2, region1, region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.5437, 0.5602, 0.5635], "spline");
  region4 = setSplineGrad(region4, region3);
  
  ##== pre extraction
  region5 = makeRegion(timeSet.preExt, [0.5635, 0.5618, 0.5463, 0.5448], "spline");
  region5 = setSplineGrad(region5, region4);
  
  ##== extraction
  region6 = makeRegion(timeSet.extract, [0.5448, 0.5448], "linear");
  
  patternSet = {region1,region2,region3,region4, region5, region6};
endfunction

function patternSet = QDPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##== capture period
  region1 = makeRegion([0, 37], [0.1042, 0.1042],"linear");
  
  ##== initial acceleration period
  region2 = makeRegion([37, 64, 91], [0.1042, 0.1075, 0.124], "spline");
  
  ##== acceleration period
  region3 = makeRegion([91, 625.4], [0.124, 0.5531], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.5531, 0.5696, 0.5729], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ##== flattop
  region5 = makeRegion(timeSet.flatTop, [0.5729, 0.5729], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction

function pattern_set = BMPattern
  ## [msec], [(T/m)*m]
  pattern_cells = {...
  0      , 0.3039, "linear";
  35     , 0.3039, "spline"; 
  60     , 0.3138, "";
  85     , 0.3633, "linear";
  625.4  , 1.6473, "spline";
  650.4  , 1.6968, "";
  675.4  , 1.7067, "linear";
  1149.6 , 1.7067, "spline";
  1174.6 , 1.6968, "";
  1199.6 , 1.6473, "linear";
  1740   , 0.3633, "spline";
  1765   , 0.3138, "";
  1790   , 0.3039, "linear";
  2000   , 0.3039, 0};

  pattern_set = build_pattern(pattern_cells);
endfunction
