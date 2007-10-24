## Usage : result = applyKickerAngle(codMatStruct, cod_rec 
##                      [, "useSteererValues", "noKickFactor"] )
##
##  * Calc COD using kick angles in cod_rec.
##  * Dispersion and momentum error are not processed.
##  * When "useSteererValues" option is given, 
##    kick angles are calculated from cod_rec.steererValues
##
##== Parameters
## * codMatStruct
##      .mat
##      .kickers
## * cod_rec
##      .steererNames
##      .kickAngles
##      .kickFactor -- optional
##   When "useSteererValues" option following fields 
##                                  is required instead of kickAngles.
##      .steererValues
##      .brho
##
##== Result
##  codMatStruct.mat * kickAngles
##      kickAngles is orderd with order of kicker elements in a ring.

##== History
## 2007-10-02
## * add option "noKickFactor"
## 2006-12-08
## * fix miscalculation when the order of steererNames doesn't follow 
##   the order in the ring.
## 2006-11-24
## * add "useSteeererValues" option

function result = applyKickerAngle(codMatStruct, cod_rec, varargin)
  use_steerer_values = false;
  use_kickfactor = true;
  if (length(varargin) > 0) 
    for n = 1:length(varargin)
      if (strcmp(varargin{n}, "useSteererValues"))
        use_steerer_values = true;
      elseif (strcmp(varargin{n}, "noKickFactor"))
        use_kickfactor = false;
      else
        error(["Unknown option : ",varargin{1}]);
      endif
    endfor
  endif
  
  if (use_steerer_values)
    value_list = cod_rec.steererValues;
  else
    value_list = cod_rec.kickAngles;
  endif
  
  ## sort cod_rec.kickAngles to match codMatStruct
  kickAngles = [];
  for n = 1:length(codMatStruct.kickers)
    target_kicker = codMatStruct.kickers{n};
    for m = 1:length(cod_rec.steererNames)
      if (strcmp(target_kicker.name, cod_rec.steererNames{m}))
        if (use_steerer_values)
          kickAngles = [kickAngles;...
          calcSteerAngle(target_kicker, value_list(m), cod_rec.brho)];
        else
          kickAngles = [kickAngles; value_list(m)];
        endif
      endif
    endfor
  endfor
  #kickAngles
  if (use_kickfactor && isfield(cod_rec, "kickFactor"))
    kickAngles *= cod_rec.kickFactor;
  endif
  
  result = codMatStruct.mat * kickAngles;
endfunction

