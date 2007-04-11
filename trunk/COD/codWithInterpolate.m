## usage : x = codWithInterpolate(s, inputValues)
##
## calculate COD with given current of steerers (steerersValues [A])  
## and return the COD at specified position (s [m]) with linear interpolation.
##
##= Parameters:
## * s -- matrix of position at which wanted COD
## * steererValue -- matrix of current of steerers [A]
##
##= Global variables :
## * _fitCODInfo -- structure which have following members
##    .lattice
##    .brho
##    .tune
##    .steererName : cell array of names of steerers which corresponding to steerersValues
##    .horv : horizontal or varticla. "h" is horizonntal. "v" is vertical.
## 
##= Result
## * x -- COD[mm] at position s
##
##= See Also
## codWithInterpWithPerror can consider momentum error. This function mainly is for vertical COD.

function x = codWithInterpolate(s, inputValues)
  global _fitCODInfo;
  #_fitCODInfo
  codRecord = _fitCODInfo;
  #codRecord.steererValues = inputValues;
  codRecord.kickAngles = inputValues;
  codRecord.pError = 0;
  codList = calcCODWithPerror(codRecord);
  x =  interp1(codList(:,1),codList(:,2),s,"linear");
endfunction
