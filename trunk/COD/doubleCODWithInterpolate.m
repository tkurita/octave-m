## usage : x = doubleCODWithInterpolate(s, inputValues)
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

function x = doubleCODWithInterpolate(s, inputValues)
  # inputValus -- STV1, QD2_FB QD2_FT QD3 ‚Æ‚·‚é
  global _fitCODInfo_FB;
  global _fitCODInfo_FT;
  global _shiftValue;
  
  inputValues
  ##= flat base
  codRecord_FB = _fitCODInfo_FB;
  codRecord_FB.steererValues = [inputValues(1); inputValues(2); inputValues(4)];
  codRecord_FB.pError = 0;
  codList_FB = calcCODWithPerror(codRecord_FB);
  
  ##= flat top
  codRecord_FT = _fitCODInfo_FT;
  codRecord_FT.steererValues = [inputValues(1); inputValues(3); inputValues(4)];
  codRecord_FT.pError = 0;
  codList_FT = calcCODWithPerror(codRecord_FT);
  
#  codList_FT = codList_FT + repmat([codList_FT(end,1), 0], size(codList_FT)(1), 1);
#  codList = [codList_FB; codList_FT];
  codList = concatCOD(codList_FB, codList_FT, _shiftValue);
  x =  interp1(codList(:,1),codList(:,2), s,"linear");  
endfunction
