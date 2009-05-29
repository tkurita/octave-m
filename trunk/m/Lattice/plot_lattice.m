## -*- texinfo -*-
## @deftypefn {Function File} {} plot_lattice(@var{lattice}, @var{opts})
##
## Plot beta-function and dispersion.
## Names of lattice elements shown on x-axis are assign by visibleLabes.
## 
## Avialble options @var{OPTS} are as follows.
## @table @code
## @item title
## plot title
## @item elements
## Names of elements to be placed on the plot.
## Cells of regular expressions of element names.
## The default value is @{"QF\\d","QD\\d","BM\\d","^ESDIN$", "^ESI$","SX\\d"@}.
## @end table 
## @end deftypefn

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
## 2009-05-26
## * If no arguments, execute print_usage()
##
## 2008-08-01
## * Use lattice_info
## 
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
  if (!nargin)
    print_usage();
    return;
  endif
  
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
  [plot_title, elem_names] = get_properties(varargin, {"title", "elements"}, ...
                                {"", {"QF\\d","QD\\d","BM\\d","^ESDIN$", "^ESI$","SX\\d"}});
  exitPositionList = value_for_keypath(latRec.lattice, "exitPosition")';
  betaFunc.h = [exitPositionList, value_for_keypath(latRec.lattice, "exitBeta.h")'];
  betaFunc.v = [exitPositionList, value_for_keypath(latRec.lattice, "exitBeta.v")'];
  dispersion = [exitPositionList, value_for_keypath(latRec.lattice, "exitDispersion")'];
  
  insertComment = lattice_info(latRec);
  ## plotting lattice

  out = {betaFunc, dispersion, elem_names ,plot_title ,insertComment};
endfunction

## Usage : _plot_lattice(allElements,betaFunction,dispersion,elem_names,titleText,insertComment)
##    Plot beta-function and dispersion.
##    Names of lattice elements shown on x-axis are assign by visibleLabes.

function retval = _plot_lattice(allElements,betaFunction,dispersion,elem_names,titleText,insertComment)
  retval = xyplot(betaFunction.h, "-@;horizontal beta;", "linewidth", 2 ...
    , betaFunction.v, "-@;vertical beta;", "linewidth", 2 ...
    , dispersion, "-@;dispersion;", "linewidth", 2);  
  if (!isempty(titleText))
    title(titleText);
  end
  ylabel("dispersion,beta [m]");
  xlabel("Position [m]");
  text("Position", [0.05, 0.95]...
    , "Units", "normalized"...
    , "String", insertComment);
  drawnow();grid on;
  elements_on_plot(elem_names, allElements, "yposition", "graph 0.05");
endfunction

function append_plot_lattice(beta_f, dispersion)
  append_plot(beta_f.h, "-@;horizontal beta;", "linewidth", 2);
  append_plot(beta_f.v, "-@;vertical beta;", "linewidth", 2);
  append_plot(dispersion, "-@;dispersion;", "linewidth", 2);
end