## usage : cod_rec = cod_correct_h_step2(cod_rec, codAtBPM)
##  - evaluate COD correction by step1
##  - obtain factored steererValues 
##    with comparing result of step1 and expected COD
##
##== Parameters
## * cod_rec : result of step1
## * codAtBPM : mesuared COD applying steerer values obtained by step1

function cod_rec = cod_correct_h_step2(cod_rec, codAtBPM)
  
  # codAtBPM = cod_hold_data("../data0908/COD0908-210849.csv", "FB");
  cod_step1 = rmfield(cod_rec, "prediction");
  cod_diff = cod_step1;
  cod_step1.codAtBPM = codAtBPM;
  cod_step1.targetCOD = buildTargetCOD(cod_step1);
  expected_cod = cod_rec.prediction.correctCOD;
  expected_cod(:,2) = expected_cod(:,2) - cod_rec.correctCOD(:,2);
  xyplot(cod_rec.targetCOD,"@-;targetCOD;"\
    , cod_rec.correctCOD,"-;correctable COD;"\
    , cod_rec.prediction.correctCOD,"-;COD prediction;"\
    , setCODOriginAt(expected_cod, cod_rec.lattice, "BPM7"), "-;expected COD after correction;"\
    , setCODOriginAt(cod_step1.targetCOD,cod_rec.lattice, "BPM7"), "-@;COD after correction;");
  
  cod_diff.codAtBPM = subtractCOD(cod_rec.codAtBPM, codAtBPM);
  cod_diff.targetCOD = buildTargetCOD(cod_diff);
  cod_diff = lFitCODWithFactor(cod_diff);
  cod_diff.kickFactor
  cod_diff.steererValues = cod_rec.steererValues/cod_diff.kickFactor;
  printKickerValues(cod_diff);
endfunction
