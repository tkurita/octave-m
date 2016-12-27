## Usage : cod_rec = cod_correct_h_step2(cod_rec, codAtBPM, ["positions", positions])
##  - evaluate COD correction by step1
##  - obtain factored steererValues 
##    with comparing result of step1 and expected COD
##
##== Parameters
## * cod_rec : result of step1
## * codAtBPM : mesuared COD applying steerer values obtained by step1
## * positions : y values for labels of element names.

function cod_rec = cod_correct_h_step2(cod_rec, codAtBPM, varargin)
  
  # codAtBPM = cod_hold_data("../data0908/COD0908-210849.csv", "FB");
  cod_step1 = rmfield(cod_rec, "prediction");
  cod_diff = cod_step1;
  cod_step1.codAtBPM = codAtBPM;
  cod_step1.targetCOD = cod_list_with_bpms(cod_step1);
#  expected_cod(:,1) = cod_rec.prediction.correctCOD(:,1);
#  expected_cod(:,2) =  cod_rec.prediction.correctCOD(:,2) - cod_rec.correctCOD(:,2);
#  cod_rec.expectedCOD = expected_cod;
  
  opts = get_properties(varargin ...
                        , {"positions", [0.5,-1,-2.5]});

  xyplot(cod_rec.targetCOD,"@-;measured COD;" ...
    , cod_rec.correctCOD,"-;result of least mean squre fit;" ...
    , cod_rec.prediction.correctCOD,"-;COD prediction;" ...
    , setCODOriginAt(cod_rec.expectedCOD, cod_rec.lattice, "BPM7") ...
    , "-;expected COD after correction;" ...
    , setCODOriginAt(cod_step1.targetCOD, cod_rec.lattice, "BPM7") ...
    , "-@;COD after correction;" ...
  ); ...
  xlabel("position [m]");ylabel("COD [mm]");grid on;xlim([0, 33.2]);
  elements_on_plot({"^BPM\\d*$"}, cod_rec.lattice...
              , "yposition", sprintf("first %f", opts.positions(1)));
  elements_on_plot({"BMPe1$", "BMPe2$", "STH*"}, cod_rec.lattice...
              , "yposition", sprintf("first %f", opts.positions(2)));
  elements_on_plot({"ESD1","^SX\\d$"}, cod_rec.lattice...
              ,"yposition", sprintf("first %f", opts.positions(3)));
  
  cod_diff.codAtBPM = subtract_cod(cod_rec.codAtBPM, codAtBPM);
  cod_diff.targetCOD = cod_list_with_bpms(cod_diff);
  cod_diff = lFitCODWithFactor(cod_diff);
  cod_diff.steererValues = cod_rec.steererValues/cod_diff.kickFactor;
  disp_kicker_values(cod_diff);
  cod_rec.kickFactor = cod_diff.kickFactor;
  cod_rec.steererValues = cod_diff.steererValues;
endfunction
