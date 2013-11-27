## -*- texinfo -*-
## @deftypefn {Function File} disp_kicker_values(@var{cod}, @var{opt})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
## 
## @seealso{}
## @end deftypefn


## Usage: disp_kicker_values(steererNames, steererValues)
##        disp_kicker_values(codRecord 
##                         [, "kickAngles" or "calcKickAngles"
##                          , "units" , "rad"])
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
##  - "factoredValues" : codRecord.steererValues .* codRecord.kickFactors

##== History
## 2013-11-27
## * ported from COD/disp_kicker_values

function disp_kicker_values(cod_obj, varargin)
  unit_factor = 1;

  steererNames = cod_obj.kickers;
  steererValues = cod_obj.kick_angles;
  out_form = "%e";

  n = 1;
  while (n <= length(varargin))
    a_option = varargin{n};
    n++;
    switch (a_option)
      case "kick_angles"
        steererValues = cod_obj.kick_angles;
      case "kickAngles"
        steererValues = cod_obj.kick_angles;
      case "calcKickAngles"
        steererValues = calcKickAngles(cod_obj);
        out_form = "%e";
      case "factoredKickAngles"
        steererValues = cod_obj.kick_angles;
        steererValues = steererValues./cod_obj.kick_factors;
        out_form = "%e";
      case "factoredValues"
        steererValues = cod_obj.steererValues(:).*cod_obj.kick_factors(:);
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

  for i = 1:length(steererNames)
    printf(["%s:",out_form,"\n"] ,steererNames{i},steererValues(i)*unit_factor);
  endfor
  
endfunction
  