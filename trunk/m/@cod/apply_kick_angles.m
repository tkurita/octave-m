## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} apply_kick_angles(@var{cod}, @var{cod_mat}, ["use_kicker_value", "no_kickfactor"])
## Calc COD using kick angles in cod_obj.
## Dispersion and momentum error are not processed.
## When "usekicker_values" option is given, 
## kick angles are calculated from cod_obj.kicker_values.
##
## @strong{Inputs}
## @table @var
## @item cod_obj
## @item cod_mat
## the output of build_matrix
## @end table
##
## @strong{Options}
## @table @code
## @item use_kicker_values
## use kicker_values instead of kick_angles.
## @item no_kickfactor
## @end table
##
## @strong{Outputs}
##
## cod_mat.mat * kick_angles
##  
## kickAngles is orderd with order of kicker elements in a ring.
## 
## @seealso{cod, build_matrix}
## @end deftypefn

##== Parameters
## * cod_mat
##      .mat
##      .kickers
## * cod_obj
##      .steererNames
##      .kickAngles
##      .kickFactor -- optional
##   When "usekicker_values" option following fields 
##                                  is required instead of kickAngles.
##      .kicker_values
##      .brho
##
##== Result
##  cod_mat.mat * kick_angles
##      kickAngles is orderd with order of kicker elements in a ring.

##== History
## 2013-11-27
## * ported from applyKickAgles.

function result = apply_kick_angles(cod_obj, cod_mat, varargin)
  use_kicker_values = false;
  use_kickfactor = true;
  if (length(varargin) > 0) 
    for n = 1:length(varargin)
      if (strcmp(varargin{n}, "use_kicker_value"))
        use_kicker_values = true;
      elseif (strcmp(varargin{n}, "no_kickfactor"))
        use_kickfactor = false;
      else
        error(["Unknown option : ",varargin{1}]);
      endif
    endfor
  endif

  if (isna(cod_obj.kick_angles))
    use_kicker_values = true;
  endif

  if (use_kicker_values)
    value_list = cod_obj.kicker_values;
  else
    value_list = cod_obj.kick_angles;
  endif
  
  ## sort cod_obj.kickAngles to match cod_mat
  kickAngles = [];
  for n = 1:length(cod_mat.kickers)
    target_kicker = cod_mat.kickers{n};
    for m = 1:length(cod_obj.kickers)
      if (strcmp(target_kicker.name, cod_obj.kickers{m}))
        if (use_kicker_values)
          kickAngles = [kickAngles;...
                kick_angle(target_kicker, value_list(m), cod_obj.brho)];
        else
          kickAngles = [kickAngles; value_list(m)];
        endif
      endif
    endfor
  endfor
  if (use_kickfactor && isfield(cod_obj ,"kick_factor"))
    kickAngles .*= cod_obj.kick_factor(:);
  endif
  result = cod_mat.mat * kickAngles;
endfunction

