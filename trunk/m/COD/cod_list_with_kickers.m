## Usage : cod_list = cod_list_with_kickers(cod_rec 
##                                [, "useSteererValues", "noKickFactor"])
##      Calculate COD with given kick angles of steerers.
##      If cod_rec has kickFactor field, kickFactor is applied.
##
## = Parameter
## * cod_rec -- structure which have following members
##     .steererNames
##     .kickAngles
##     .pError -- momentum error
##     .lattice
##     .tune
##     .horv -- 水平方向と垂直方向のどちらを計算するか
##     .kickFactor
##
## = Result
## * cod_list -- matrix of COD at exit position of each element. 
##     [position, COD]

##== History
## 2007.10.02
## * add option "noKickFactor"
## * rename from calcCODWithPerror
##
## 2006.11.24
## * add "useSteererValues" option, i.e. add support of steererValues.
## * change name from cod_list_with_kickers2 to cod_list_with_kickers.
## * confirm that giving same result to old cod_list_with_kickers 
##   in both case using kickAngles and steererValues.
##
## 2006.08.18
## * matrix を使ったもう少し賢い cod_list_with_kickers
## * cod_list_with_kickers との違いは steererValues をサポートしない（いまのところは）
## * cod_list_with_kickers と同じ結果を与えることを確認

function cod_list = cod_list_with_kickers(cod_rec, varargin)
  codMatStruct = buildCODMatrix(cod_rec, "full");
  use_kickfactor = true;
  use_steerer_values = false;
  if (length(varargin) > 0) 
    for n = 1:length(varargin)
      if strcmp(varargin{n}, "useSteererValues")
        use_steerer_valuse = true;
      elseif strcmp(varargin{n}, "noKickFactor")
        use_kickfactor = false;
      else
        warning([varargin{n}, " is unknown option\n"]);
      endif
    endfor
  else
    varargin = {};
  endif
  
  if (!use_steerer_values )
    if (isfield(cod_rec, "steererValues") )
      varargin{end+1} = "useSteererValues";
    else
      error("cod_rec don't have kickAngles field.");
    endif
  endif
  
  cod_list = applyKickerAngle(codMatStruct, cod_rec, varargin{:});
  
  if (strcmp(cod_rec.horv,"h"))
    cod_list = cod_list + codMatStruct.dispersion*cod_rec.pError;
  endif
  cod_list = cod_list*1000;
  positionList = codMatStruct.positions;
  if (isfield(cod_rec, "range"))
    begPos = cod_rec.range(1);
    endPos = cod_rec.range(2);
    
    for i = 1 : length(positionList)
      if ((positionList(i) <= begPos) || (endPos <= positionList(i)))
        cod_list(i) = 0;
      endif
    endfor
    
  endif
  
  cod_list = [positionList, cod_list];
endfunction
