## Usage : plot_lattice(lat_record, [, plot_title ,visible_labels])
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

##== History
## 2008-07-25
## * support only lattice_records as arguments
## * can multiple lattice plottings
## 
## 2008-04-30
## * names of elements are plotted by elements_on_plot
## 
## 2007-11-01
## * update for 2.9.14

function retval = plot_lattice(first_arg, varargin)
  if (isstruct(first_arg))
    rest_args = prepare_plot(first_arg, varargin{:});
    retval = _plot_lattice(first_arg.lattice, rest_args{:});

  elseif (iscell(first_arg))
    args = prepare_plot(first_arg{1}, varargin{:});
    xyplot(args{1}.h, "-@;horizontal beta;", "linewidth", 2 ...
      , args{1}.v, "-@;vertical beta;", "linewidth", 2 ...
      , args{2}, "-@;dispersion;", "linewidth", 2);  
    title(args{4});
    ylabel("dispersion,beta [m]");
    xlabel("Position [m]");    
    elem_labels = args{3};
    ins_comment = args{5};
    for n = 2:length(first_arg)
      args = prepare_plot(first_arg{n});
      append_plot_lattice(args{1}, args{2});
      ins_comment = strcat(ins_comment, "\n\n", args{5});
    endfor
    text("Position", [0.05, 0.95]...
      , "Units", "normalized"...
      , "String", ins_comment);
    drawnow();grid on;
    elements_on_plot(elem_labels, first_arg{1}.lattice, "yposition", "graph 0.05");
  endif
endfunction

function  out = prepare_plot(latRec, varargin);

  exitPositionList = value_for_keypath(latRec.lattice, "exitPosition")';
  betaFunc.h = [exitPositionList, value_for_keypath(latRec.lattice, "exitBeta.h")'];
  betaFunc.v = [exitPositionList, value_for_keypath(latRec.lattice, "exitBeta.v")'];
  dispersion = [exitPositionList, value_for_keypath(latRec.lattice, "exitDispersion")'];

  tuneText = printTune(latRec.tune);
  
  returnText = "\n";
  insertComment = "";
  if (isfield(latRec, "qfk"))
    qfk_comment = sprintf("qfk:%g", latRec.qfk) # ans = -0.0062874
    qdk_comment = sprintf("qdk:%g", latRec.qdk) # ans = 1.4558
    insertComment = [qfk_comment, returnText, qdk_comment, returnText];
  endif
  
  alpha = momentum_compaction_factor(latRec.lattice);
  alpha_comment = sprintf("momentum compaction factor:%g",alpha)
  # momentum compaction factor:0.612075
  
  ## calc chromaticity
  chrom = chromaticity(latRec.lattice);
  chrom_h_comment = sprintf("horizontal chromaticity:%g",chrom.h)
  # chrom_h_comment = horizontal chromaticity:-0.966016
  chrom_v_comment = sprintf("vertical chromaticity:%g",chrom.v)
  # chrom_v_comment = vertical chromaticity:-0.804463
  
  insertComment = [insertComment\
    , tuneText(1,:),returnText\
    , tuneText(2,:),returnText\
    , alpha_comment, returnText\
    , chrom_h_comment, returnText\
    , chrom_v_comment];
  
  ## plotting lattice
  
  
  visibleLabels = {"QF\\d","QD\\d","BM\\d","^ESDIN$", "^ESI$","SX\\d"};
  plot_title = "";
  if (length(varargin) > 0)
    plot_title = varargin{1};
  endif
  
  if (length(varargin) > 1)
    visibleLabels = varargin{2};
  endif
  out = {betaFunc, dispersion, visibleLabels ,plot_title ,insertComment};
endfunction

## Usage : _plot_lattice(allElements,betaFunction,dispersion,visibleLabels,titleText,insertComment)
##    Plot beta-function and dispersion.
##    Names of lattice elements shown on x-axis are assign by visibleLabes.

function retval = _plot_lattice(allElements,betaFunction,dispersion,visibleLabels,titleText,insertComment)
  ##labels of name of elements on x axis
  #__gnuplot_raw__("unset label\n");
  
  ##plot
  retval = xyplot(betaFunction.h, "-@;horizontal beta;", "linewidth", 2 ...
    , betaFunction.v, "-@;vertical beta;", "linewidth", 2 ...
    , dispersion, "-@;dispersion;", "linewidth", 2);  
  title(titleText);
  ylabel("dispersion,beta [m]");
  xlabel("Position [m]");
  text("Position", [0.05, 0.95]...
    , "Units", "normalized"...
    , "String", insertComment);
  drawnow();grid on;
  elements_on_plot(visibleLabels, allElements);
endfunction

function append_plot_lattice(beta_f, dispersion)
  append_plot(beta_f.h, "-@;horizontal beta;", "linewidth", 2);
  append_plot(beta_f.v, "-@;vertical beta;", "linewidth", 2);
  append_plot(dispersion, "-@;dispersion;", "linewidth", 2);
end