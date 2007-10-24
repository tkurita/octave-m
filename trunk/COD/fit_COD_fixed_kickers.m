function fit_COD_fixed_kickers(cod_rec, fixed_kicker_info)
  cod_rec_fkickers = setupfixed_kicker_info(fixed_kicker_info, cod_rec);
  
  
endfunction

function cod_rec_fkickers = setupfixed_kicker_info(fixed_kicker_info, cod_rec)
  try
    isKickAngle = fixed_kicker_info.isKickAngle;
  catch
    isKickAngle = false;
  end_try_catch
  
  cod_rec_fkickers = setfields(cod_rec\
    , "steererNames", fixed_kicker_info.names, "pError", 0);
  
  if (isKickAngle)
    cod_rec_fkickers.kickAngles = fixed_kicker_info.values;
  else
    kickAngles = [];
    for i = 1:length(fixed_kicker_info.names);
      currentElement = getElementWithName(cod_rec.lattice, fixed_kicker_info.names{i});
      kickAngles(i) = calcSteerAngle(currentElement, fixed_kicker_info.values(i), cod_rec.brho);
    endfor
    cod_rec_fkickers.kickAngles = kickAngles;
  endif
  
  if (isfield(fixed_kicker_info, "range"))
    cod_rec_fkickers.range = fixed_kicker_info.range;
  endif
  
  cod_rec_fkickers.COD = calcCODWithPerror(cod_rec_fkickers);
endfunction