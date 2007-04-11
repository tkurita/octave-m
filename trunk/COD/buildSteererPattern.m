## usage : [steererTimeLine, steererMat]  = buildSteererPattern(codRecordList)
##
##= result
## * steererTimeLine -- 時間
## * steererMat
## 

function [steererTimeLine, steererMat]  = buildSteererPattern(codRecordList)
  #codRecordList = codRecList
  steererNames = codRecordList{1}.steererNames;
  timeLine = valuesForKey(codRecordList, {"time"});
  #blLine = valuesForKey(codRecordList, {"brho"})*(pi/4);
  blLine = BValuesAtTimes(BMPattern, timeLine);
  strValuesMat = (valuesForKey(codRecordList, {"steererValues"}))';
  
  [fixedTimes, fixedBL] = definedPoints(BMPattern);
  
  fixedTimes = create_set(fixedTimes);
  fixedBL = BValuesAtTimes(BMPattern, fixedTimes);
      # steerer の補正値が計算された値での BM の BL 値
  
  blAtCorrectPoints = BValuesAtTimes(BMPattern, timeLine);
  blAtCorrectMat = repmat(blAtCorrectPoints, 1, size(strValuesMat)(2));
  angleMat = strValuesMat./blAtCorrectMat;
  #timeLine(:)
  #fixedTimes(:)
  interAngleMat = interp1(blLine(:), angleMat, fixedBL(:), "linear","extrap");
  strMatAtFixedPoints = interAngleMat .* repmat(fixedBL,1, size(interAngleMat)(2));
  repmat(fixedBL,1, size(interAngleMat)(2));
  unionTimes = union(timeLine, fixedTimes);
  
  unionMat = [];
  uAngleMat = [];
  for i = 1:length(unionTimes)
    t = unionTimes(i);
    theIdx = indexInVector(timeLine, t);
    if (theIdx) 
      unionMat = [unionMat; strValuesMat(theIdx, :)];
      continue;
    endif
    
    theIdx = indexInVector(fixedTimes, t);
    if (theIdx)
      unionMat = [unionMat; strMatAtFixedPoints(theIdx,:)];
    else
      error("can't find steerer value for time : %g", t);
    endif
  endfor
  steererTimeLine = unionTimes(:);
  steererMat = unionMat;
endfunction
