## Usage : mean_value = fit_profile(filepath, plot_title, horv)
##  apply gaussian to Profile Hold Data and obtain mean value
##
##= Parameters
##  * filepath -- path to Profile Hold data
##  * plot_title
##  * horv -- "h" or "v"
##
##= Result 
##  mean value of gaussian fit

function mean_value = fit_profile(filepath, plot_title, horv)
  pr = loadProfileCVS(filepath);
  valid_limit = 3000;
  for n = 1:rows(pr.(horv))
    if pr.(horv)(n,2) > 3000
      pr.(horv)(n,2) = 0;
    endif
  endfor
  
  title(plot_title);
  xlabel("Position [mm]")
  ylabel("")
  axis("auto")
  xyplot(pr.(horv), "-@;;");
  initial_values = [1000, 10, 0];
  fit_result_pr = gaussianFit(pr.(horv), initial_values);
  #fit_result_pr
  mean_value = fit_result_pr(3);
  unsetarrow()
  vline(mean_value);
endfunction