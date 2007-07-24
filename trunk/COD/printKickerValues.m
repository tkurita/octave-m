## Usage: printKickerValues(steererNames, steererValues)
##        printKickerValues(codRecord 
##                              [, "kickAngles" or "calcKickAngles"])
##
##  If codRecord is passed and no options, 
##        "steererValues" fields will be display.
## 
##== Parameters
## * codRecord -- a structure which have following fields
##       .steererNames
##       .steererValues
##       .kickAngles (optional)
##
## * options -- following strings
##  - "kickAngles" : display "kickAngles" field instead of "steererValues" field.
##  - "calcKickAngels" : calculate kick angles from steererValues field.
##  - "factoredKickAngles" : codRecord.kickAngles./codRecord.kickFactors

function printKickerValues(varargin)
  if (isstruct(varargin{1}))
    steererNames = varargin{1}.steererNames;
    steererValues = varargin{1}.steererValues;
    out_form = "%f";
    if (length(varargin) > 1)
      for n = 2:length(varargin)
        a_option = varargin{n};
        switch (a_option)
          case "kickAngles"
            steererValues = varargin{1}.kickAngles;
            out_form = "%e";
          case "calcKickAngles"
            steererValues = calcKickAngles(varargin{1});
            out_form = "%e";
          case "factoredKickAngles"
            is_factoredKickAngles = false;
            steererValues = varargin{1}.kickAngles;
            steererValues = steererValues./varargin{1}.kickFactors;
            out_form = "%e";
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
    printf(["%s:",out_form,"\n"] ,steererNames{i},steererValues(i));
  endfor
  
endfunction
  