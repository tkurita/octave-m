## usage : x = codWithInterpolate(s, steererValues)
##
## calculate COD with given current of steerers (steerersValues [A])  
## and return the COD at specified position (s [m]) with linear interpolation.
##
##== parameters:
## * steererValue : matrix of current of steerers [A]
## * s : matrix of position at which wanted COD
##
##== global variables
## * _ficCODInfo
##    members:
##      .steererNames : cell array of names of steerers which corresponding to steerersValues
##      .steererValues
##      .lattice
##      .brho
##      .tune
##      .horv : horizontal or varticla. "h" is horizonntal. "v" is vertical.
## 
##== result
## * x : COD[mm] at position s

##= History
## 2006.07.17
##  パラメータとして、steererValues ではなく、kickAngles を使うようにした。
##  fixied kicker 機能が壊れている。

function x = codByFactorAndPerror(s, inputValues)
  global _fitCODInfo;
  global _existsFixedKicker; # 固定された kicker element が存在するかどうか
                             # fitCOD 内で設定される
                             # 入/出射バンプ計算用
  global _fixedKickerInfo;
  
  codRecord = _fitCODInfo;
  codRecord.steererValues = codRecord.steererValues * inputValues(1);
  #codRecord.kickAngles = inputValues(1:end-1);
  
  if (codRecord.ignorePerror)
    codRecord.pError = 0;
  else
    codRecord.pError = inputValues(end);
  endif
  
  codList = calcCODWithPerror(codRecord);
  
  if (_existsFixedKicker)
    codRecord_Fix = _fitCODInfo;
    codRecord_Fix.steererValues = _fixedKickerInfo.values;
    codRecord_Fix.steererNames = _fixedKickerInfo.names;
    codRecord_Fix.pError = 0;
    if (isfield(_fixedKickerInfo, "range"))
      codRecord_Fix.range = _fixedKickerInfo.range;
    endif
    codList_Fix = calcCODWithPerror(codRecord_Fix);
    codList(:,2) = codList(:,2) + codList_Fix(:,2); 
#    codList = calcCODWithPerror(codRecord);
#    codRecord.steererValues = [codRecord.steererValues; _fixedKickerInfo.values];
#    codRecord.steererNames = {codRecord.steererNames{:} _fixedKickerInfo.names{:}};
  endif
  
  x =  interp1(codList(:,1), codList(:,2), s, "linear");
endfunction
