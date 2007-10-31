## usage : codList = calcCODWithPerror(codRecord)
##
## calculate COD with given current of steerers (steererValues [A])
##
## = parameter
## * codRecord -- structure which have following members
##     .steererNames
##     .steererValues or .kickAngles
##     .pError -- 運動量誤差
##     .lattice
##     .brho -- 運動量の基準となる量として必要 
##     .tune
##     .horv -- 水平方向と垂直方向のどちらを計算するか
##
## = result
## * codList -- matrix of COD at exit position of each element. 
##     [position(m) ; COD(mm) ]

## = History
## 2006-11-24
## * obsolute
##
## 2006.08.16
##  出力に element の center での値を追加した
##
## 2006.07.14
##  codRecord.kickAngles があったらそちらを使うようにした。
##  steererValues のサポートは実質的には必要ない。
##  

function codList = calcCODWithPerror20061124(codRecord)
  #global _fitCODInfo;
  #  fieldnames(codRecord)
  #  codRecord.steererNames
  steererNames = codRecord.steererNames;
  #steererValues = codRecord.steererValues;
  isKickAngles = isfield(codRecord, "kickAngles");
  if (isKickAngles)
    valueList = codRecord.kickAngles;
  else
    valueList = codRecord.steererValues;
    brho = codRecord.brho;
  endif
  
  p_error = codRecord.pError;
  allElements = codRecord.lattice;
  tune = codRecord.tune;
  horv = codRecord.horv;
  
  stBetaList = []; # beta function at exit position of steerers
  stPhaseList = []; # phase advance at exit position of steerers
  betaList = []; # beta function at exit position of each element
  phaseList = []; # phase advance at exit position of each element
  positionList = [];
  dispersionList = [];
  steererF = [];
  
  for m = 1:length(allElements)
    currentElement = allElements{m};
    for n = 1 : length(steererNames)
      if (strcmp(allElements{m}.name,steererNames{n}))
        stPhaseList = [stPhaseList, currentElement.centerPhase.(horv)];
        stBetaList = [stBetaList, currentElement.centerBeta.(horv)];
        if (isKickAngles)
          steererF = [steererF, valueList(n)];
        else
          steererF = [steererF, calcSteerAngle(currentElement,valueList(n),brho)];
        endif
        break;
      endif
    endfor
    betaList = [betaList\
      ,currentElement.centerBeta.(horv), currentElement.exitBeta.(horv)];
    phaseList = [phaseList\
      , currentElement.centerPhase.(horv), currentElement.exitPhase.(horv)];
    
    positionList = [positionList;
    currentElement.centerPosition; currentElement.exitPosition];
    
    dispersionList = [dispersionList;
    currentElement.centerDispersion; currentElement.exitDispersion];
    
  endfor
  
  codList = [];
  
  for n = 1:length(phaseList) 
    theCOD = (sqrt(betaList(n))/(2*sin(pi*tune.(horv))) )* \
    sum(sqrt(stBetaList) .*steererF.*cos(pi*tune.(horv)-abs(phaseList(n) - stPhaseList)));
    if (strcmp(horv,"h"))
      theCOD += dispersionList(n)*p_error;
    endif
    codList = [codList; theCOD];
  endfor
  
  codList = codList*1000;
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
