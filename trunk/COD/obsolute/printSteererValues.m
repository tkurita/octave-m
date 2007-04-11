## usage: printSteererValues(steererNames,steererValues)
##        printSteererValues(codRecord)
##        printSteererValues(codRecord, "kickAngles")
## codRecord
##       .steererNames
##       .steererValues
##
function printSteererValues(varargin)
  warning("printSteererValues is obsolute, use printKickerValues");
  if (isstruct(varargin{1}))
    steererNames = varargin{1}.steererNames;
    if (length(varargin) > 1)
      steererValues = varargin{1}.(varargin{2});
  elseif (iscell(varargin{1}))
    steererNames = varargin{1};
    steererValues = varargin{2};
  else
    error("first argument must be a cell array or a structure.");
  endif
  
    #  if (length(varargin) == 1)
    #    steererNames = varargin{1}.steererNames;
    #    steererValues = varargin{1}.steererValues;
    #  else
    #    steererNames = varargin{1};
    #    steererValues = varargin{2};
    #  endif
    for i = 1:length(steererNames)
      printf("%s:%g\n",steererNames{i},steererValues(i));
    endfor

endfunction