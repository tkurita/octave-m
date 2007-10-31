function plotMagnetPattern(varargin)
  ## usage: plotMagnetPattern(patternSet1,paterrnSet2,...,ylabel)
  #varargin = {BM_p200}
  narg = length(varargin);
  if (nargin < 2) 
    printf("usage: plotMagnetPattern(patternSet1,paterrnSet2,...,ylabel)\n");
  endif
  
  argPlot = {};
  for j = 1:(nargin -1)
    patternSet=varargin{j};
    startTime = patternSet{1}.tPoints(1);
    endTime = patternSet{end}.tPoints(end);
    [bLine,tLine] = BValuesForTimes(patternSet,0.1);
    tPoints = [];
    bPoints = [];
    for i = 1:length(patternSet)
      tPoints = [tPoints; patternSet{i}.tPoints(:)];
      bPoints = [bPoints; patternSet{i}.bPoints(:)];
    endfor
    argPlot = {argPlot{:},tLine,bLine,"",tPoints,bPoints,"@"};
  endfor
  xlabel("[msec]");
  ylabel(varargin{end});
  plot(argPlot{:});
endfunction
