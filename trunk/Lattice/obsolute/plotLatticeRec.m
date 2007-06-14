## usage : plotLatticeRec(latRec [, plot_title ,visible_labels])
##
function plotLatticeRec(latRec, varargin)
  warning("obsolute, use plot_lattice");
  tuneText = printTune(latRec.tune);
  # horizontal ture:1.31562
  # vertial ture:1.18495
  returnText = "\\n";
  insertComment = "";
  if (isfield(latRec, "qfk"))
    qfk_comment = sprintf("qfk:%g", latRec.qfk) # ans = -0.0062874
    qdk_comment = sprintf("qdk:%g", latRec.qdk) # ans = 1.4558
    insertComment = [qfk_comment, returnText, qdk_comment, returnText];
  endif
  
  exitPositionList = valuesForKey(latRec.lattice, {"exitPosition"})';
  betaFunc.h = [exitPositionList, valuesForKey(latRec.lattice, {"exitBeta","h"})'];
  betaFunc.v = [exitPositionList, valuesForKey(latRec.lattice, {"exitBeta","v"})'];
  dispersion = [exitPositionList, valuesForKey(latRec.lattice, {"exitDispersion"})'];
  
  alpha = momentumCompactionFactor(latRec.lattice);
  alpha_comment = sprintf("momentum compaction factor:%g",alpha) 
  # momentum compaction factor:0.612075
  
  ## calc chromaticity
  chrom = chromaticity(latRec.lattice);
  chrom_h_comment = sprintf("horizontal chromaticity:%g",chrom.h)
  # chrom_h_comment = horizontal chromaticity:-0.966016
  chrom_v_comment = sprintf("vertical chromaticity:%g",chrom.v)
  # chrom_v_comment = vertical chromaticity:-0.804463
  
  ## plotting lattice
  
  insertComment = [insertComment\
    , tuneText(1,:),returnText\
    , tuneText(2,:),returnText\
    , alpha_comment, returnText\
    , chrom_h_comment, returnText\
    , chrom_v_comment];
  
  visibleLabels = {"QF","QD","BM","ES","SX"};
  plot_title = "";
  if (length(varargin) > 0)
    plot_title = varargin{1};
  endif
  
  if (length(varargin) > 1)
    visibleLabels = varargin{2};
  endif

  plotLattice(latRec.lattice,betaFunc,dispersion,visibleLabels\
    ,plot_title\
    ,insertComment)
endfunction
