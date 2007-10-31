function result = plotArgumentForCoeff(coeffMat, nxrange, nyrange)
  #coeffMat = [2;-2];
  #coeffMat = targetCoeffs
  #coeffMat
  lineRecList = {};
  for n = 1:size(coeffMat)(2)
    newRecs = lineRecsInRange(coeffMat(:,n), nxrange, nyrange);
    lineRecList = [lineRecList, newRecs];
  endfor
  
 
  if (length(lineRecList) == 0)
    result = {};
    return;
  endif
  
  lineRecList{1}.plotFmt = plotFmtForLineRec(lineRecList{1}, "withKind");
  result = {lineRecList{1}.plotData, lineRecList{1}.plotFmt};
  
  for i = 2:length(lineRecList)
    lineRecList{i}.plotFmt = plotFmtForLineRec(lineRecList{i});
    result{end+1} = lineRecList{i}.plotData;
    result{end+1} = lineRecList{i}.plotFmt;
  endfor
endfunction