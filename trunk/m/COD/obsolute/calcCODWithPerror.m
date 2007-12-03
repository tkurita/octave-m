## Usage : codList = calcCODWithPerror2(codRecord [, "useSteererValues"])
##      obsolute. use cod_list_with_kickers
##      Calculate COD with given kick angles of steerers
##
## = Parameter
## * codRecord -- structure which have following members
##     .steererNames
##     .kickAngles
##     .pError -- momentum error
##     .lattice
##     .tune
##     .horv -- 水平方向と垂直方向のどちらを計算するか
##
## = Result
## * codList -- matrix of COD at exit position of each element. 
##     [position, COD]

##== History
## 2007.10.02
## * obsolute. use cod_list_with_kickers
## 2006.11.24
## * add "useSteererValues" option, i.e. add support of steererValues.
## * change name from calcCODWithPerror2 to calcCODWithPerror.
## * confirm that giving same result to old calcCODWithPerror 
##   in both case using kickAngles and steererValues.
##
## 2006.08.18
## * matrix を使ったもう少し賢い calcCODWithPerror
## * calcCODWithPerror との違いは steererValues をサポートしない（いまのところは）
## * calcCODWithPerror と同じ結果を与えることを確認

function codList = calcCODWithPerror(codRecord, varargin)
  #warning("calcCODWithPerror is obsolete. Use cod_list_with_kickers");
  error("calcCODWithPerror is obsolete. Use cod_list_with_kickers");
  
  codMatStruct = buildCODMatrix(codRecord, "full");
  
  if (length(varargin) == 0) 
    if (!isfield(codRecord, "kickAngles") )
      if (isfield(codRecord, "steererValues") )
        varargin{1} = "useSteererValues";
      else
        error("codRecord don't have kickAngles field.");
      endif
    endif
  endif
  
  codList = applyKickerAngle(codMatStruct, codRecord, varargin{:});
  
  if (strcmp(codRecord.horv,"h"))
    codList = codList + codMatStruct.dispersion*codRecord.pError;
  endif
  codList = codList*1000;
  positionList = codMatStruct.positions;
  if (isfield(codRecord, "range"))
    begPos = codRecord.range(1);
    endPos = codRecord.range(2);
    
    for i = 1 : length(positionList)
      if ((positionList(i) <= begPos) || (endPos <= positionList(i)))
        codList(i) = 0;
      endif
    endfor
    
  endif
  
  codList = [positionList, codList];
endfunction
