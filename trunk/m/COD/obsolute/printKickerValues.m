## Usage: printKickerValues(steererNames, steererValues)
##        printKickerValues(codRecord 
##                         [, "kickAngles" or "calcKickAngles"
##                          , "units" , "rad"])
##  Deprecated. Use "disp_kicker_values"
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
  warning("printKickerValues is deprecated. Use disp_kicker_values");
  unit_factor = 1;
  if (isstruct(varargin{1}))
    steererNames = varargin{1}.steererNames;
    steererValues = varargin{1}.steererValues;
    out_form = "%f";
    if (length(varargin) > 1)
      n = 2;
      #for n = 2:length(varargin)
      while (n <= length(varargin))
        a_option = varargin{n};
        n++;
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
          case "units"
            switch (varargin{n})
              case "mrad"
                unit_factor = 1000;
              case "rad"
                unit_factor = 1;
              otherwise
                error([varargin{n}, " is unknown unit."]);
            endswitch
            n++;
          otherwise
            error([varargin{n}, " is unknown option."]);
        endswitch
      end
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
    printf(["%s:",out_form,"\n"] ,steererNames{i},steererValues(i)*unit_factor);
  endfor
  
endfunction
  