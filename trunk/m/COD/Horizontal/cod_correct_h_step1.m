## Usage : cod_rec = cod_correct_h_step1(lattice_rec, codAtBPM
##                       [, "positions", [0.5,-1,-2.5], "units", "data"])
##  - calculate lattice with tune.
##  - fit COD with steerers
##  - fit COD with kicks at BM
##
##== Parameters
## * lattice_rec
## * codAtBPM
## * optionals
##    - "positions" : vertical position of labels
##                    1: BPM*
##                    2: STH* and BMPe*
##                    3: Vertical Steerer]
##                    default value is [0.5, -1, -2.5]
##    - "units" : "data"(default) , "normalized" or "screnn"


function cod_rec = cod_correct_h_step1(cod_rec, codAtBPM, varargin)
  text();
  # measured_tune = struct("h", 1.691572954, "v", 0.797153025);
  # codAtBPM = cod_hold_data("../data0907/COD/COD0907-153359.csv", "FB")
  steerer_names = {"STH2", "STH3", "STH4", "STH5", "STH6"};
  bm_names = {"BM1", "BM2", "BM3", "BM4", "BM5", "BM6", "BM7","BM8"};
  
  cod_rec = append_fields(cod_rec, codAtBPM, steerer_names);
  cod_rec.horv = "h";
  cod_rec.targetCOD = cod_list_with_bpms(cod_rec);
  cod_rec = lFitCOD(cod_rec);
  cod_rec.correctCOD = cod_list_with_kickers(cod_rec);
  [positions, units] = get_properties(varargin...
                        , {"positions", "units"}, {[0.5,-1,-2.5], "data"});
  cod_rec_BM = setfields(cod_rec, "steererNames", bm_names);
  cod_rec_BM = lFitCOD(cod_rec_BM);
  cod_rec_BM.correctCOD = cod_list_with_kickers(cod_rec_BM);
  cod_rec.prediction = cod_rec_BM;
  cod_rec.expectedCOD = [cod_rec_BM.correctCOD(:,1)...
                      , cod_rec_BM.correctCOD(:,2) - cod_rec.correctCOD(:,2)];
  setBPandSHonXaxis(cod_rec.lattice, positions, units);
  label_pos = 0;
  if (length(positions) > 3)
    label_pos = positions(end);
  endif
  elements_on_plot({"ESD","SX"}, cod_rec.lattice...
                  ,"yposition", sprintf("first %f", label_pos));
  plotCODFit(cod_rec);
  hold on
  xyplot(cod_rec_BM.correctCOD, ";fit with kicks at BM;")
  hold off
endfunction

