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
##
## 2006.09.08
## * fixed kicker 機能を復活
## * _fiexedKickerInfo.value はキック角とする。
## * 電流値や、BL積からのキック角への変換は fitCOD で行う。
##
## 2006.07.17
## * パラメータとして、steererValues ではなく、kickAngles を使うようにした。
## * fixied kicker 機能が壊れている。

function result = codWithInterpWithPerror(s, inputValues)
  global _fitCODInfo;
  global _existsFixedKicker; # 固定された kicker element が存在するかどうか
                             # fitCOD 内で設定される
                             # 入/出射バンプ計算用
  global _fixedKickerInfo;
  
  codRecord = _fitCODInfo;
  codRecord.kickAngles = inputValues(1:end-1);
  codRecord.pError = inputValues(end);
  codList = calcCODWithPerror(codRecord);
  
  if (_existsFixedKicker)    
    codList(:,2) = codList(:,2) + _fixedKickerInfo.COD(:,2);
  endif
  
  result =  interp1(codList(:,1),codList(:,2),s,"linear");
endfunction
