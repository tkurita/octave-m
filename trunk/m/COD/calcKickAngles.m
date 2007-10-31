## Usage : kickAngles = calcKickAngles(codRecord)
##      Calculate kick angles of codRecord.steererNames
##      using codRecord.steererValues

function kickAngles = calcKickAngles(codRecord)
  kickAngles = [];
  value_list = codRecord.steererValues;
  for n = 1:length(codRecord.steererNames)
    kickerName = codRecord.steererNames{n};
    for m = 1:length(codRecord.lattice)
      theElement = codRecord.lattice{m};
      if (strcmp(kickerName, theElement.name))
        kickAngles(end+1) = calcSteerAngle(theElement, value_list(n), codRecord.brho);
        break;
      endif
    endfor
  endfor
  
  kickAngles = kickAngles(:);
endfunction

