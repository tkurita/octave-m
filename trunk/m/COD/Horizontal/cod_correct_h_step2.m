## Usage : cod_rec = cod_correct_h_step2(cod_rec, codAtBPM)
##  - evaluate COD correction by step1
##  - obtain factored steererValues 
##    with comparing result of step1 and expected COD
##
##== Parameters
## * cod_rec : result of step1
## * codAtBPM : mesuared COD applying steerer values obtained by step1

##== History
## * 2007.09.05
##  add expectedCOD into returend structure
##
## * 2007.???
##  initial
function cod_rec = cod_correct_h_step2(cod_rec, codAtBPM)
  
  # codAtBPM = cod_hold_data("../data0908/COD0908-210849.csv", "FB");
  cod_step1 = rmfield(cod_rec, "prediction");
  cod_diff = cod_step1;
  cod_step1.codAtBPM = codAtBPM;
  cod_step1.targetCOD = cod_list_with_bpms(cod_step1);
#  expected_cod(:,1) = cod_rec.prediction.correctCOD(:,1);
#  expected_cod(:,2) =  cod_rec.prediction.correctCOD(:,2) - cod_rec.correctCOD(:,2);
#  cod_rec.expectedCOD = expected_cod;
  xlabel("position [m]")
  ylabel("COD [mm]")
  xyplot(cod_rec.targetCOD,"@-;measured COD;"\
    , cod_rec.correctCOD,"-;result of least mean squre fit;"\
    , cod_rec.prediction.correctCOD,"-;COD prediction;"\
    , setCODOriginAt(cod_rec.expectedCOD, cod_rec.lattice, "BPM7"), "-;expected COD after correction;"\
    , setCODOriginAt(cod_step1.targetCOD,cod_rec.lattice, "BPM7"), "-@;COD after correction;");
  
  cod_diff.codAtBPM = subtract_cod(cod_rec.codAtBPM, codAtBPM);
  cod_diff.targetCOD = cod_list_with_bpms(cod_diff);
  cod_diff = lFitCODWithFactor(cod_diff);
  cod_diff.kickFactor
  cod_diff.steererValues = cod_rec.steererValues/cod_diff.kickFactor;
  printKickerValues(cod_diff);
endfunction
