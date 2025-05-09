## usage: plot_bpattern(patternSet1,paterrnSet2,...,ylabel)

function plot_bpattern(varargin)
  #varargin = {BM_p200}
  narg = length(varargin);
  if (nargin < 2) 
    error("usage: plot_bpattern(patternSet1,paterrnSet2,...,ylabel)");
  endif
  
  argPlot = {};
  for j = 1:(nargin -1)
    patternSet=varargin{j};
    startTime = patternSet{1}.tPoints(1);
    endTime = patternSet{end}.tPoints(end);
    [bLine,tLine] = bvalues_for_period(patternSet,0.1);
    tPoints = [];
    bPoints = [];
    for i = 1:length(patternSet)
      tPoints = [tPoints; patternSet{i}.tPoints(:)];
      bPoints = [bPoints; patternSet{i}.bPoints(:)];
    endfor
    argPlot = {argPlot{:}, tLine,bLine,"-", tPoints,bPoints,"*"};
  endfor
  argPlot
  plot(argPlot{:});
  xlabel("time [ms]");
  ylabel(varargin{end});
endfunction
