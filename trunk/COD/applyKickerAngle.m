## Usage : result = applyKickerAngle(codMatStruct, codRecord [, "useSteererValues"] )
##      * Calc COD using kick angles in codRecord.
##      * Dispersion and momentum error are not processed.
##      * When "useSteererValues" option is given, 
##        kick angles are calculated from codRecord.steererValues
##
## = Parameters
## * codMatStruct
##      .mat
##      .kickers
## * codRecord
##      .steererNames
##      .kickAngles
##   When "useSteererValues" option following fields is required instead of kickAngles.
##      .steererValues
##      .brho
##
## = Result
##  codMatStruct.mat * kickAngles
##      kickAngles is orderd with order of kicker elements in a ring.

## = History
## 2006-12-08
##  * fix miscalculation when the order of steererNames doesn't follow the order in the ring.
## 2006-11-24
##  * add "useSteeererValues" option

function result = applyKickerAngle(codMatStruct, codRecord, varargin)
  useSteererValues = false;
  if (length(varargin) > 0) 
    if (strcmp(varargin{1}, "useSteererValues"))
      useSteererValues = true;
    else
      error(["Unknown option : ",varargin{1}]);
    endif
  endif
  
  if (useSteererValues)
    value_list = codRecord.steererValues;
  else
    value_list = codRecord.kickAngles;
  endif
  
  ## sort codRecord.kickAngles to match codMatStruct
  kickAngles = [];
  for n = 1:length(codMatStruct.kickers)
    target_kicker = codMatStruct.kickers{n};
    for m = 1:length(codRecord.steererNames)
      if (strcmp(target_kicker.name, codRecord.steererNames{m}))
        if (useSteererValues)
          kickAngles = [kickAngles; calcSteerAngle(target_kicker, value_list(m), codRecord.brho)];
        else
          kickAngles = [kickAngles; value_list(m)];
        endif
      endif
    endfor
  endfor
  #kickAngles
  if (isfield(codRecord, "kickFactor"))
    kickAngles *= codRecord.kickFactor;
  endif
  
  result = codMatStruct.mat * kickAngles;
endfunction

