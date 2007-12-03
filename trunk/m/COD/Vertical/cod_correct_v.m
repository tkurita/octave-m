## Usage : [cod_rec_FB, cod_rec_FT] = cod_correct_v(cod_rec_FB, cod_rec_FT)
##  Fit vertical COD with STV1, QD2, QD3
##
##= cod_rec must have following records
##  .tune
##  .time
##  .lattice
##  .codAtBPM
##
##= SAMPLE
##
## # flat base
## cod_rec_FB.measured_tune = struct("h", 1.690317988, "v", 0.805410536);
## cod_rec_FB.time = 35;
## cod_rec_FB = lattice_with_time_tune(cod_rec_FB);
## cod_rec_FB.codAtBPM = struct("BPM3", 632/200, "BPM6", -1107/200 \
##                            , "PR1", -2.9678, "PR2", 1.4234);
##
## # flat top
## cod_rec_FT.measured_tune = struct("h", 1.683, "v", 0.792);
## cod_rec_FT.time = 700;
## cod_rec_FT = lattice_with_time_tune(cod_rec_FT);
## cod_rec_FT.codAtBPM = struct("BPM3", 381/200, "BPM6", -742/200);
##
## # fit
## [cod_rec_FB, cod_rec_FT] = cod_correct_v(cod_rec_FB, cod_rec_FT);

##== History
## 2007-12-03
## * update obsolete functions

function [cod_rec_FB, cod_rec_FT] = cod_correct_v(cod_rec_FB, cod_rec_FT, varargin)
  cod_rec_FB = setup_cod_rec_v(cod_rec_FB);
  cod_rec_FT = setup_cod_rec_v(cod_rec_FT);
  [cod_rec_FB, cod_rec_FT] = doublelFitCOD(cod_rec_FB, cod_rec_FT, {"QD2"}, varargin{:});
  
  cod_rec_FB.correctCOD = cod_list_with_kickers(cod_rec_FB);
  cod_rec_FT.correctCOD = cod_list_with_kickers(cod_rec_FT);
  
  xlabel("Position [m]");
  ylabel("COD [mm]");
  grid on;
  visibleLabels = {"BM", "STV1", "QF", "QD", "SM"};
  #elements_on_plot(visibleLabels, cod_rec_FB.lattice, "clear", "yposition", "first 0");
  elements_on_plot(visibleLabels, cod_rec_FB.lattice, "clear", "yposition", "graph 0.5");
  elements_on_plot({"BPM3", "BPM6", "PR1","PR2"}, cod_rec_FB.lattice, "yposition", "graph 0.1");
  
  xyplot(cod_rec_FB.targetCOD, "-@;Measured COD at Flat Base;"\
    , cod_rec_FB.correctCOD, "-;Fitting Result for Flat Base;"\
    , cod_rec_FB.prediction.correctCOD, "-;Predicated COD with QD2, QD4, L18_1 at FB;"\
    , cod_rec_FT.targetCOD, "-@;Measured COD at Flat Top;"\
    , cod_rec_FT.correctCOD, "-;Fitting Result for Flat Top;"\
    , cod_rec_FT.prediction.correctCOD, "-;Predicated COD with QD2, QD4, L18_1 at FT;");
  grid on;
  
  printf("At Flat Base\n");
  printKickerValues(cod_rec_FB);
  printf("At Flat Top\n");
  printKickerValues(cod_rec_FT);  
endfunction

function cod_rec = setup_cod_rec_v(cod_rec)
  cod_rec.horv = "v";
  cod_rec.steererNames = {"STV1","QD2","QD3"};
  cod_rec.targetCOD = cod_list_with_bpms(cod_rec);
  cod_rec.prediction = cod_fit_with_kickers(cod_rec, {"QD2", "QD4", "L18_1"});
endfunction
