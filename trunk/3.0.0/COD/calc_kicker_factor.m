## Usage : kicker_factor =...
##          calc_kicker_factor(on_cod, off_cod, lattice_rec, kicker_name, kicker_value
##                              [, plot_options , ...])
##  calculate a retio between kicker setting and a kikcer setting given by COD fit.
##  
##  kicker_factor is defined as :
##    (setting value)/(fitting result)
##
##  (kicker_facotr > 1) means kick angle is smaller than expected.
##  
##  If plot potions is passed as arguments, plot of COD and fitting is shown.
##
##= Parameters 
##  * on_cod
##  * off_cod
##  * lattice_rec
##  * kicker_name
##  * kicker_value
##  * plot_options -- following properties can be available.
##    * "visible_elements"
##    * "on_label"
##    * "off_label"
##    * "title"
##= SAMPLE
## codAtBPM1.BPM3 = 700/200; # ans = 3.5000 [mm]
## codAtBPM1.BPM6 = -1120/200; # ans = -5.6000 [m]
##
## codAtBPM0.BPM3 = 456/200; # ans = -2.2800 [mm]
## codAtBPM0.BPM6 = -644/200; # ans = -3.2200 [mm]
##
## calc_kicker_factor(codAtBPM1, codAtBPM0, cod_rec_FB, "STV1", -2);

##== History
## 2007-12-03
## * subtractCOD -> subtract_cod
## * buildTargetCOD -> cod_list_with_bpms
## * setElementsOnPlot -> elements_on_plot
## * calcCODWithPerror -> cod_list_with_kickers
## * remove pointsize

function kicker_factor =...
  calc_kicker_factor(on_cod, off_cod, lattice_rec, kicker_name, kicker_value, varargin)
  lattice_rec.codAtBPM = subtract_cod(on_cod, off_cod);
  lattice_rec.targetCOD = cod_list_with_bpms(lattice_rec);
  lattice_rec.steererNames = {kicker_name};
  lattice_rec = lFitCOD(lattice_rec);
  fit_result = lattice_rec.steererValues;
  kicker_factor = kicker_value/fit_result;
  
  if (length(varargin) <1)
    return
  endif
  
  visible_elements = {kicker_name};
  on_label = "";
  off_label = "";
  plot_title = "";
  for n = 1:length(varargin)
    an_arg = varargin{n};
    if (ischar(an_arg))
      if (strcmp(an_arg, "visible_elements"))
        visible_elements = [visible_elements, varargin{n+1}];
      elseif (strcmp(an_arg, "on_label"))
        on_label = varargin{n+1};
      elseif (strcmp(an_arg, "off_label"))
        off_label = varargin{n+1};
      elseif (strcmp(an_arg, "title"))
        plot_title = varargin{n+1};  
      endif
    endif
    
  endfor
  
  cod_rec_on = setfields(lattice_rec, "codAtBPM", on_cod);
  cod_rec_on.targetCOD = cod_list_with_bpms(cod_rec_on);
  cod_rec_off = setfields(lattice_rec, "codAtBPM", off_cod);
  cod_rec_off.targetCOD = cod_list_with_bpms(cod_rec_off);
  
  xlabel("Position [m]");
  ylabel("COD [mm]");
  title(plot_title);
  grid on;
  elements_on_plot(visible_elements, lattice_rec.lattice, "clear", "yposition", "graph 0.5");
  elements_on_plot(fieldnames(on_cod), lattice_rec.lattice, "yposition", "graph 0.1");
  xyplot(cod_rec_on.targetCOD, ["-@;",on_label,";"], "MarkerSize", 2 \
    , cod_rec_off.targetCOD, ["-@;",off_label,";"], "MarkerSize", 2\
    , lattice_rec.targetCOD, ["-@;difference of COD;"], "MarkerSize", 2 \
    , cod_list_with_kickers(lattice_rec)\
    , sprintf("-;fitting result: %.4f [mrad]/%.2f [A];", lattice_rec.kickAngles*1e3, kicker_value)
  );grid on;

endfunction