## Usage: printKickerValues(steererNames, steererValues)
##        printSteererValues(codRecord [, "kickAngles" or "calcKickAngles"])
##
## = Parameters
## * codRecord -- a structure which have following fields
##       .steererNames
##       .steererValues
## * options -- following strings
##  - "kickAngles"
##  - "calcKickAngels"
##  - "factoredKickAngles"

function printKickerValues(varargin)
  if (isstruct(varargin{1}))
    steererNames = varargin{1}.steererNames;
    steererValues = varargin{1}.steererValues;
    
    if (length(varargin) > 1)
      for n = 2:length(varargin)
        a_option = varargin{n};
        switch (a_option)
          case "kickAngles"
            steererValues = varargin{1}.kickAngles;
          case "calcKickAngles"
            steererValues = calcKickAngles(varargin{1});
          case "factoredKickAngles"
            is_factoredKickAngles = false;
            steererValues = varargin{1}.kickAngles;
            steererValues = steererValues./varargin{1}.kickFactors;
          otherwise
            error([varargin{n}, " is unknown option."]);
        endswitch
      endfor
    else
      steererValues = varargin{1}.steererValues;
    endif
    
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
    printf("%s:%e\n",steererNames{i},steererValues(i));
  endfor
  
endfunction
  