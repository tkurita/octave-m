## Usage : codList = calcCOD_old(cod_record)
##    昔の COD を計算するコード
##    dispersion を考慮していない
##    calculate COD with given current of steerers (steererValues [A])
##
## = Parameters
## cod_record is a structure which must have folloing fields.
##  .steereNames 
##  .steererValues
##  .lattice
##  .brho -- 運動量の基準となる量として必要
##  .tune
##  .horv -- 水平方向と垂直方向のどちらを計算するか
##
## = Result
## codList -- matrix of COD at exit position of each element. 

function codList = calcCOD_old(cod_rec)
  codList = calcCOD_old_core(cod_rec.steererNames, cod_rec.steererValues\
    , cod_rec.lattice, cod_rec.brho, cod_rec.tune, cod_rec.horv)
endfunction

## codList = calcCOD(steererNames,steererValues,allElements,brho,tune)
function codList = calcCOD_old_core(steererNames,steererValues,allElements,brho,tune,horv)
  
  stBetaList = []; # beta function at exit position of steerers
  stPhaseList = []; # phase advance at exit position of steerers
  betaList = []; # beta function at exit position of each element
  phaseList = []; # phase advance at exit position of each element
  positionList = [];
  steererF = [];
  for m = 1:length(allElements)
    currentElement = allElements{m};
    for n = 1 : length(steererNames)
      if (strcmp(allElements{m}.name,steererNames{n}))
        stPhaseList = [stPhaseList, allElements{m}.exitPhase.(horv)];
        stBetaList = [stBetaList, allElements{m}.exitBeta.(horv)];
        steererF = [steererF, calcSteerAngle(currentElement,steererValues(n),brho)];
        #steererF = [steererF, steererAtoB(steererValues(n))*allElements{m}.len/brho];
        break;
      endif
    endfor
    betaList = [betaList, allElements{m}.exitBeta.(horv)];
    phaseList = [phaseList, allElements{m}.exitPhase.(horv)];
    positionList = [positionList;allElements{m}.exitPosition];
  endfor
  
  codList = [];
  for n = 1:length(phaseList) 
    theCOD = (sqrt(betaList(n))/(2*sin(pi*tune.(horv))) )*\
    sum(sqrt(stBetaList) .*steererF .*cos(pi*tune.(horv)-abs(phaseList(n) - stPhaseList)));
    codList = [codList;theCOD*1000];
  endfor
  codList = [positionList,codList];
endfunction
