## BM pattern of H+ 10MeV -> 50MeV H20E
1; #script file

##== Hisotory
## 2014-04-07
## * make BMPattern

#function timeSet = timeRegion
#  timeSet.capture = [0,35];
#  timeSet.initialAcc = [35,60,85];
#  timeSet.acc = [85, 599.2];
#  timeSet.postAcc = [599.2,624.2,649.2];
#  timeSet.flatTop = [649.2, 1175.8];
#  timeSet.preExt = [649.2, 661.7, 686.7, 699.2];
#  timeSet.extract = [699.2, 1125.8];
#endfunction
#
#function patternSet = QFPattern
#  ## [msec], [(T/m)*m]
#  timeSet = timeRegion;
#  ##== capture period
#  region1 = makeRegion(timeSet.capture, [0.1173, 0.1173],"linear");
#  
#  ##== initial acceleration period
#  region2 = makeRegion(timeSet.initialAcc, [0.1173, 0.1207, 0.1371], "spline");
#  
#  ##== acceleration period
#  region3 = makeRegion(timeSet.acc, [0.1371, 0.5437], "linear");
#  
#  region2 = setSplineGrad(region2,region1,region3);
#  
#  ##== end of acceleration period
#  region4 = makeRegion(timeSet.postAcc, [0.5437, 0.5602, 0.5635], "spline");
#  region4 = setSplineGrad(region4, region3);
#  
#  ##== pre extraction
#  region5 = makeRegion(timeSet.preExt, [0.5635, 0.5619, 0.5464, 0.5449], "spline");
#  region5 = setSplineGrad(region5, region4);
#  
#  ##== extraction
#  region6 = makeRegion(timeSet.extract, [0.5449, 0.5449], "linear");
#  
#  patternSet = {region1,region2,region3,region4, region5, region6};
#endfunction
#
#function patternSet = QDPattern
#  ## [msec], [(T/m)*m]
#  timeSet = timeRegion;
#  ##== capture period
#  region1 = makeRegion([0,37], [0.1255, 0.1255],"linear");
#  
#  ##== initial acceleration period
#  region2 = makeRegion([37, 64, 91], [0.1255, 0.1288, 0.1452], "spline");
#  
#  ##== acceleration period
#  region3 = makeRegion([91, 599.2], [0.1452, 0.5531], "linear");
#  
#  region2 = setSplineGrad(region2,region1,region3);
#  
#  ##== end of acceleration period
#  region4 = makeRegion(timeSet.postAcc, [0.5531, 0.5696, 0.5729], "spline");
#  region4 = setSplineGrad(region4,region3);
#  
#  ##== flattop
#  region5 = makeRegion(timeSet.flatTop, [0.5729, 0.5729], "linear");
#  
#  patternSet = {region1,region2,region3,region4, region5};
#endfunction

function patternSet = BMPattern
    ## [msec], [(T/m)*m]
  pattern_cells = ...
  {...
  0	, 0.3662, "linear";
  35	, 0.3662, "spline";
  60	, 0.3761, "";
  85	, 0.4256, "linear";
  226.8	, 0.7626, "spline";
  251.8	, 0.8121, "";
  276.8	, 0.822, "linear";
  1548.2	, 0.822, "spline";
  1573.2	, 0.8121, "";
  1598.2	, 0.7626, "linear";
  1740	, 0.4256, "spline";
  1765	, 0.3761, "";
  1790	, 0.3662, "linear";
  2000	, 0.3662 , 0};
  
  patternSet = build_pattern(pattern_cells);  
endfunction