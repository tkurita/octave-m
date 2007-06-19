## usage : cod_rec = cod_correct_h_step1(measured_tune, codAtBPM, time)
##  - calculate lattice with tune.
##  - fit COD with steerers
##  - fit COD with kicks at BM

function cod_rec = cod_correct_h_step1(cod_rec, codAtBPM)
  
  # measured_tune = struct("h", 1.691572954, "v", 0.797153025);
  # codAtBPM = cod_hold_data("../data0907/COD/COD0907-153359.csv", "FB")
  steererNames = {"STH2", "STH3", "STH4", "STH5", "STH6"};
  bm_names = {"BM1", "BM2", "BM3", "BM4", "BM5", "BM6", "BM7","BM8"};
  
  cod_rec = append_fields(cod_rec, codAtBPM, steererNames);
  cod_rec.horv = "h";

  cod_rec_BM = setfields(cod_rec, "steererNames", bm_names);
  cod_rec_BM = lFitCOD(cod_rec_BM);
  cod_rec_BM.correctCOD = calcCODWithPerror(cod_rec_BM);
  cod_rec.prediction = cod_rec_BM;
  setBPandSHonXaxis(cod_rec.lattice,[0.5,-1,-2.5]);
  setElementNamesOnXaxis(cod_rec.lattice, {"BMPe","ESD","SX"}, 0)
  plotCODFit(cod_rec);
  hold on
  xyplot(cod_rec_BM.correctCOD, ";fit with kicks at BM;")
  hold off
endfunction

