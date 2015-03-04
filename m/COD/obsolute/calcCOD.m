## codList = calcCOD(steererNames,steererValues,allElements,brho,tune)
##
## calculate COD with given current of steerers (steererValues [A])
##
## parameters:
## steereNames:
## steererValues
## allElements
## brho : 運動量の基準となる量として必要
## tune
## horv : 水平方向と垂直方向のどちらを計算するか
## result
## codList : matrix of COD at exit position of each element. 

function codList = calcCOD(steererNames,steererValues,allElements,brho,tune,horv)
  codList = calcCODWithPerror(steererNames, steererValues, 0, allElements, brho, tune, horv);
endfunction
