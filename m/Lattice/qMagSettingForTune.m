## usage : result = qMagSettingForTune(tunex,tuney, qCalibRecord, brho)
##
##= arguments
## * tunex
## * tuney
## * qCalibRecord -- output of searchQCalibration
## * brho
##
##= result
## retuned structure will have following fields
##      .qfSet
##      .qdSet
##      .lattice
##      .tune
##      .qfk
##      .qdk
##      .tune
##      .measured_tune -- holding arguments of tunex, tuney

function result = qMagSettingForTune(tunex, tuney, qCalibRecord, brho)
  # tunex = 1.690317988
  # tuney = 0.833
  rec.measured_tune.h = tunex;
  rec.measured_tune.v = tuney;
  rec = calcLatticeForTune(rec);
  result = qMagSetting(rec, qCalibRecord, brho);
endfunction