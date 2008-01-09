## Usage : plot_lattice(lat_record, [, plot_title ,visible_labels])
##          or
##         plot_lattice(allElements, betaFunction, dispersion,
##                          visibleLabels, titleText, insertComment)
##
##    Plot beta-function and dispersion.
##    Names of lattice elements shown on x-axis are assign by visibleLabes.
##
##= Parameters
##  * lat_record's fields
##    - lattice
##    - tune
##    - qfk
##    - qdk

function plot_lattice(first_arg, varargin)
  if (isstruct(first_arg))
    rest_args = prepare_plot(first_arg, varargin{:});
    _plot_lattice(first_arg.lattice, rest_args{:});
  else
    _plot_lattice(first_arg.lattice, varargin{:});
  endif
endfunction

function  out = prepare_plot(latRec, varargin);
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
  out = {betaFunc, dispersion, visibleLabels ,plot_title ,insertComment};
endfunction

## Usage : plotLattice(allElements,betaFunction,dispersion,visibleLabels,titleText,insertComment)
##    Plot beta-function and dispersion.
##    Names of lattice elements shown on x-axis are assign by visibleLabes.

function _plot_lattice(allElements,betaFunction,dispersion,visibleLabels,titleText,insertComment)
  ##labels of name of elements on x axis
  #__gnuplot_raw__("unset label\n");
  text();
  thePosition = 0;
  for n = 1:length(allElements)
    theElement = allElements{n};
    xPosition = thePosition+(theElement.len/2);
    for n = 1:length(visibleLabels)
      visibleName = visibleLabels{n};
      findAns = findstr(theElement.name,visibleName,0);
      if (length(findAns) && findAns(1)==1)
        text("Position", [xPosition, 0]\
          , "Rotation", 90\
          , "String", theElement.name)
        
        break;
      endif
    end
    thePosition = thePosition + theElement.len;
  end
  
  ##plot
  text("Position", [0.05, 0.95]\
    , "Units", "normalized"\
    , "String", insertComment)
  
  title(titleText);
  ylabel("dispersion,beta [m]");
  xlabel("Position [m]");
  xyplot(betaFunction.h, "-@;horizontal beta;", betaFunction.v, "-@;vertical beta;", dispersion, "-@;dispersion;");
endfunction