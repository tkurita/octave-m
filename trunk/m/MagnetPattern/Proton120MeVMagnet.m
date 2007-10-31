## BM pattern of H+ 10MeV -> 120MeV H12E
1; #script file

function timeSet = timeRegion
  timeSet.capture = [0,35];
  timeSet.initialAcc = [35,60,85];
  timeSet.acc = [85, 426.5];
  timeSet.postAcc = [426.5, 451.5, 476.5];
  timeSet.flatTop = [476.5, 1308.5];
  timeSet.preExt = [476.5, 489, 514, 526.5];
  timeSet.extract = [526.5, 1167.9];
endfunction

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##== capture period
  region1 = makeRegion(timeSet.capture, [0.1173, 0.1173],"linear");
  
  ##== initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.1173, 0.1206, 0.1369], "spline");

  ##== acceleration period
  region3 = makeRegion(timeSet.acc, [0.1369, 0.4053], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.4053, 0.4217, 0.4249], "spline");
  region4 = setSplineGrad(region4, region3);
  
  ##== pre extraction
  region5 = makeRegion(timeSet.preExt, [0.4249, 0.4242, 0.4164, 0.4157], "spline");
  region5 = setSplineGrad(region5, region4);
  
  ##== extraction
  region6 = makeRegion(timeSet.extract, [0.4157, 0.4157], "linear");
  
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
  region3 = makeRegion([91, 426.5], [0.1452, 0.4153], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ##== end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.4153, 0.4318, 0.4351], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ##== flattop
  region5 = makeRegion(timeSet.flatTop, [0.4351, 0.4351], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction

function patternSet = BMPattern
  timeSet = timeRegion;
  ## capture period
  ## [msec], [T*m]
  region1 = makeRegion(timeSet.capture,[0.3662, 0.3662],"linear");
  
  ## initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.3662, 0.3761, 0.4256], "spline");
  
  ## acceleration period
  region3 = makeRegion(timeSet.acc, [0.4256, 1.2369], "linear");
  
  region2 = setSplineGrad(region2,region1,region3);
  
  ## end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [1.2369, 1.2864, 1.2963], "spline");
  region4 = setSplineGrad(region4,region3);
  
  ## flat top
  region5 = makeRegion(timeSet.extract, [1.2963, 1.2963], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction
