## BM pattern of H+ 10MeV -> 160MeV H16E
1; #script file

function timeSet = timeRegion
  timeSet.capture = [0,35];
  timeSet.initialAcc = [35,60,85];
  timeSet.acc = [85, 517.1];
  timeSet.postAcc = [517.1, 542.1, 567.1];
  timeSet.flatTop = [567.1, 1217.9];
  timeSet.preExt = [567.1, 579.6, 604.6, 617.1];
  timeSet.extract = [617.1, 1123.1];
endfunction

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##== capture period
  region1 = makeRegion(timeSet.capture, [0.1173, 0.1173],"linear");
  
  ##== initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.1173, 0.1207, 0.1371], "spline");

  ##== acceleration period
  region3 = makeRegion(timeSet.acc, [0.1371, 0.4759], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.4759, 0.4923, 0.4956], "spline");
  region4 = setSplineGrad(region4, region3);
  
  ##== pre extraction
  region5 = makeRegion(timeSet.preExt, [0.4956, 0.4947, 0.4857, 0.4848], "spline");
  region5 = setSplineGrad(region5, region4);
  
  ##== extraction
  region6 = makeRegion(timeSet.extract, [0.4848, 0.4848], "linear");
  
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
  region3 = makeRegion([91, 599.2], [0.1452, 0.4876], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.4876, 0.5041, 0.5047], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ##== flattop
  region5 = makeRegion(timeSet.flatTop, [0.5047, 0.5047], "linear");
  
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
  region3 = makeRegion(timeSet.acc, [0.4256, 1.4524], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ## end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [1.4524, 1.5019, 1.5118], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ## flat top
  region5 = makeRegion(timeSet.extract, [1.5118, 1.5118], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction
