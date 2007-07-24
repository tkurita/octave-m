## Usage : kicker_factor =...
##          calc_kicker_factor(on_cod, off_cod, lattice_rec, kicker_name, kicker_value)
##  calculate a retio between kicker setting and a kikcer setting given by COD fit.
##  
##  kicker_factor is defined as :
##    (setting value)/(fitting result)
##
##  (kicker_facotr > 1) means kick angle is smaller than expected.
##
##= Parameters 
##  * on_cod
##  * off_cod
##  * lattice_rec
##  * kicker_name
##  * kicker_value
##
##= SAMPLE
## codAtBPM1.BPM3 = 700/200; # ans = 3.5000 [mm]
## codAtBPM1.BPM6 = -1120/200; # ans = -5.6000 [m]
##
## codAtBPM0.BPM3 = 456/200; # ans = -2.2800 [mm]
## codAtBPM0.BPM6 = -644/200; # ans = -3.2200 [mm]
##
## calc_kicker_factor(codAtBPM1, codAtBPM0, cod_rec_FB, "STV1", -2);

function kicker_factor =...
  calc_kicker_factor(on_cod, off_cod, lattice_rec, kicker_name, kicker_value)
  lattice_rec.codAtBPM = subtractCOD(on_cod, off_cod);
  lattice_rec.targetCOD = buildTargetCOD(lattice_rec);
  lattice_rec.steererNames = {kicker_name};
  lattice_rec = lFitCOD(lattice_rec);
  fit_result = lattice_rec.steererValues;
  kicker_factor = kicker_value/fit_result;
endfunction