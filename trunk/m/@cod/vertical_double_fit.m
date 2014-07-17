## Usage : [cod_FB, cod_FT] = cod_correct_v(cod_FB, cod_FT)
##  Fit vertical COD with STV1, QD2, QD3
##
##= cod_rec must have following records
##  .tune
##  .time
##  .lattice
##  .codAtBPM
##
##= Options
## * "useWeight" : cod_rec must have a "weights" field.
## * "noPrecition" : no COD prediction in the plot.
## * "steererNames" : give a cell array of steerer names for COD correction.
## * "errorKickers" : give a cell array of steerer names for COD prediction.
## 
##= SAMPLE
##
## # flat base
## cod_FB.measured_tune = struct("h", 1.690317988, "v", 0.805410536);
## cod_FB.time = 35;
## cod_FB = lattice_with_time_tune(cod_FB);
## cod_FB.codAtBPM = struct("BPM3", 632/200, "BPM6", -1107/200 \
##                            , "PR1", -2.9678, "PR2", 1.4234);
##
## # flat top
## cod_FT.measured_tune = struct("h", 1.683, "v", 0.792);
## cod_FT.time = 700;
## cod_FT = lattice_with_time_tune(cod_FT);
## cod_FT.codAtBPM = struct("BPM3", 381/200, "BPM6", -742/200);
##
## # fit
## [cod_FB, cod_FT] = cod_correct_v(cod_FB, cod_FT);

##== History
## 2013-06-20
## * added "variableKickers" options
## 2013-06-19
## * added "steererNames" option.
## * added "errorKickers" option.
## * added "noPrediciton" option.
## 2007-12-03
## * update obsolete functions

function [cod_FB, cod_FT] = ...
              vertical_double_fit(cod_FB, cod_FT, varargin)
  cod_FB = setup_for_vertical(cod_FB, varargin{:});
  cod_FT = setup_for_vertical(cod_FT, varargin{:});
  opts = get_properties(varargin,...
                      {"pattern_kickers"},...
                      {{"QD2"}});
  [cod_FB, cod_FT] = double_fit(cod_FB, cod_FT,...
                                   opts.pattern_kickers, varargin{:});
  
#  cod_FB.correctCOD = cod_list_with_kickers(cod_FB);
#  cod_FT.correctCOD = cod_list_with_kickers(cod_FT);
  
  use_prediction = false;
  for n = 1:length(varargin)
    if (strcmp(varargin{n}, "prediction"))
      use_prediction = true;
      break;
    endif
  endfor
  
  xyplot(vs_positions(cod_FB), "-@;Measured COD at Flat Base;",...
         by_kickers(cod_FB), "-;Fitting Result for Flat Base;");
  if (use_prediction)
    append_plot(cod_FB.prediction.correctCOD, ...
                 "-;Predicated COD with QD2, QD4, SMIN at FB;");
  endif
  append_plot(vs_positions(cod_FT), "-*;Measured COD at Flat Top;",...
            by_kickers(cod_FT), "-;Fitting Result for Flat Top;");
  if (use_prediction)
    append_plot(cod_FT.prediction.correctCOD, ...
                  "-;Predicated COD with QD2, QD4, SMIN at FT;");
  endif
  grid on;xlabel("Position [m]");ylabel("COD [mm]");
  visibleLabels = {"^BM\\d$", "^STV1$", "^QF\\d$", "^QD\\d$", "SM"};
  elements_on_plot(visibleLabels, cod_FB.ring.lattice,...
                   "clear", "yposition", "graph 0.5");
  #elements_on_plot(visibleLabels, cod_FB.lattice, "clear", "yposition", "first 0");
  elements_on_plot({"^BPM3$", "^BPM6$", "^PR1$","^PR2$"},...
                 cod_FB.ring.lattice, "yposition", "graph 0.1");

  printf("At Flat Base\n");
  disp_kick_angles(cod_FB);
  printf("At Flat Top\n");
  disp_kick_angles(cod_FT);  
endfunction

function cod_obj = setup_for_vertical(cod_obj, varargin)
  cod_obj.horv = "v";
  [kickers, error_kickers] = get_properties(varargin,...
                        {"kickers" ,"error_kickers"},...
                         {{"STV1","QD2","QD3"}, {"QD2", "QD4", "SMIN"}});
  cod_obj.kickers = kickers;
  #cod_obj.targetCOD = cod_list_with_bpms(cod_obj);
  #cod_obj.prediction = cod_fit_with_kickers(cod_obj, error_kickers);
endfunction
