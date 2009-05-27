## BM pattern of Carbon 6+ 25MeV -> 660MeV
1; #script file

#LOADPATH=['~/share/octave:' DEFAULT_LOADPATH];

function timeSet = timeRegion
  timeSet.capture = [0,35];
  timeSet.initialAcc = [35,60,85];
  timeSet.acc = [85,625.4];
  timeSet.postAcc = [625.4,650.4,675.4];
  timeSet.flatTop = [675.4, 1149.6];
  timeSet.extract = [725.4, 1099.6];
endfunction

function patternSet = QFPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##= capture period
  region1 = makeRegion(timeSet.capture,  [0.1058, 0.1058],"linear");

  ##= initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.1058, 0.1089, 0.1247], "spline");

  ##= acceleration period
  region3 = makeRegion(timeSet.acc, [0.1247, 0.5324], "linear");

  region2 = setSplineGrad(region2,region1,region3);

  ##= end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [0.5324, 0.5482, 0.5513], "spline");
  region4 = setSplineGrad(region4,region3);

  ##= preparing extraction
  region5 = makeRegion([675.4, 687.9, 719.2, 725.4], 
            [0.5513, 0.5505, 0.5419, 0.5411], "spline");
  
  ##= extraction period
  region6 = makeRegion([725.4, 1099.6], [0.5411, 0.5411], "linear");

  region5 = setSplineGrad(region5, region4, region6);

  ##= preparing deacceleration
  region7 = makeRegion([1099.6, 1112.1, 1137.1, 1149.6],
            [0.5411, 0.5417, 0.5505, 0.5513],"spline");
  region7 = setSplineGrad(region7, region6);
  
  patternSet = {region1,region2,region3,region4, region5, region6, region7 };

endfunction

function patternSet = QDPattern
  ## [msec], [(T/m)*m]
  timeSet = timeRegion;
  ##= capture period
  region1 = makeRegion([0,37], [0.1131, 0.1131],"linear");

  ##= initial acceleration period
  region2 = makeRegion([37, 64, 91], [0.1131, 0.1164, 0.1333], "spline");

  ##= acceleration period
  region3 = makeRegion([91, 625.4], [0.1333, 0.5695], "linear");

  region2 = setSplineGrad(region2,region1,region3);

  ##= end of acceleration period
  region4 = makeRegion([625.4, 650.4 ,675.4], [0.5695, 0.5863, 0.5897], "spline");
  region4 = setSplineGrad(region4,region3);

  ##= flat top
  region5 = makeRegion(timeSet.flatTop, [0.5897, 0.5897], "linear");
  
  patternSet = {region1,region2,region3,region4, region5};
endfunction

function patternSet = BMPattern
  timeSet = timeRegion;
  ## capture period
  ## [msec], [T*m]
  ##= capture period
  region1 = makeRegion(timeSet.capture,[0.3299,0.3299],"linear");
  
  ##= initial acceleration period
  region2 = makeRegion(timeSet.initialAcc, [0.3299,0.3398,0.3889], "spline");

  ##= acceleration period
  region3 = makeRegion(timeSet.acc, [0.3889,1.6641], "linear");

  region2 = setSplineGrad(region2,region1,region3);

  ##= end of acceleration period
  region4 = makeRegion(timeSet.postAcc, [1.6641,1.7133, 1.7232], "spline");
  region4 = setSplineGrad(region4,region3);

  ##= extraction period
  region5 = makeRegion(timeSet.flatTop, [1.7232, 1.7232], "linear");

  patternSet = {region1, region2, region3, region4, region5};
endfunction
