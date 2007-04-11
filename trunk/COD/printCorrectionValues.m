## usage: printSteererValues(steererNames,steererValues)
##               or
## printSteererValues(codRecord)
## codRecord
##       .steererNames
##       .steererValues
##
function printCorrectionValues(codRecord, varargin)
  isTeXTable = false;
  if (length(varargin) > 0)
    isTeXTable = containStr(varargin, "textable");
  endif
  
  if (isTeXTable)
    printf("name\t& setting value [A]\t& kick angle [mrad] \\\\\n");
    printf("\\hline \\hline \n");
    ptemplate = "%s\t& %g\t& %.2g \\\\\n";
    steererValueFactor = -1;
    kickAngleFactor = -1000;
  else
    ptemplate = "%s\t%g\t%.2g\n";
    steererValueFactor = 1;
    kickAngleFactor = 1;
  endif
  
  for i = 1:length(codRecord.steererNames)
    printf(ptemplate\
      ,codRecord.steererNames{i}, -1*codRecord.steererValues(i), codRecord.kickAngles(i));
  endfor
endfunction
  