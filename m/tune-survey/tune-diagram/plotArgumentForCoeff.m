function result = plotArgumentForCoeff(coeffMat, nxrange, nyrange, colors)
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
  
  lineRecList{1}.plotFmt = plotFmtForLineRec(lineRecList{1}, "with_kind"...
                                                , "colors", colors);
  result = {lineRecList{1}.plotData, lineRecList{1}.plotFmt};
  
  for n = 2:length(lineRecList)
    lineRecList{n}.plotFmt = plotFmtForLineRec(lineRecList{n}, "colors", colors);
    result{end+1} = lineRecList{n}.plotData;
    result{end+1} = lineRecList{n}.plotFmt;
  endfor
  result = flat_cell(result);
endfunction