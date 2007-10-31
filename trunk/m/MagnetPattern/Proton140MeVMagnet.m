## BM pattern of H+ 10MeV -> 160MeV H16E
1; #script file

function timeSet = timeRegion
  timeSet.capture = [0,35];
  timeSet.initialAcc = [35,60,85];
  timeSet.acc = [85, 473.1];
  timeSet.postAcc = [473.1, 498.1, 523.1];
  timeSet.flatTop = [523.1, 1261.9];
  timeSet.preExt = [timeSet.flatTop(1), 535.6, 560.6, 573.1];
  timeSet.extract = [timeSet.preExt(end), 1211.9];
endfunction

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##== capture period
  region1 = makeRegion(timeSet.capture, [0.1173, 0.1173], "linear");
  
  ##== initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.1173, 0.1206, 0.1369], "spline");

  ##== acceleration period
  region3 = makeRegion(timeSet.acc, [0.1369, 0.4416], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.4416, 0.458, 0.4613], "spline");
  region4 = setSplineGrad(region4, region3);
  
  ##== pre extraction
  region5 = makeRegion(timeSet.preExt, [0.4613, 0.4604, 0.4521, 0.4512], "spline");
  region5 = setSplineGrad(region5, region4);
  
  ##== extraction
  region6 = makeRegion(timeSet.extract, [0.4512, 0.4512], "linear");
  
  patternSet = {region1,region2,region3,region4, region5, region6};
endfunction

function patternSet = QDPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##== capture period
  region1 = makeRegion([0,37], [0.1255, 0.1255],"linear");
  
  ##== initial acceleration period
  region2 = makeRegion([37, 64, 91], [0.1255, 0.1288, 0.1452], "spline");
  
  ##== acceleration period
  region3 = makeRegion([91, 473.1], [0.1452, 0.4568], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.4568, 0.4736, 0.4769], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ##== flattop
  region5 = makeRegion(timeSet.flatTop, [0.4769, 0.4769], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction

function patternSet = BMPattern
  timeSet = timeRegion;
  ## capture period
  ## [msec], [T*m]
  region1 = makeRegion(timeSet.capture,[0.3662,0.3662],"linear");
  
  ## initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.3662,0.3761,0.4256], "spline");
  
  ## acceleration period
  region3 = makeRegion(timeSet.acc, [0.4256, 1.3478], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ## end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [1.3478, 1.3973, 1.4072], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ## flat top
  region5 = makeRegion(timeSet.extract, [1.4072, 1.4072], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction
