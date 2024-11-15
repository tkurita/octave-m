## Usage : [fit_center, gravity_point]
##                  = fit_profile(filepath, plot_title, horv)
##
##  Apply gaussian to Profile Hold Data and obtain mean value
##  (center of gaussian).
##  Also calculate gravity point.
##
##= Parameters
##  * filepath -- path to Profile Hold data
##  * plot_title
##  * horv -- "h" or "v"
##
##= Result 
##  mean value of gaussian fit

##== History
## 2007-12-03
## * update for 2.9.14

function varargout = fit_profile(filepath, plot_title, horv)
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
  #unsetarrow()
  vline(mean_value);
  gp = gravity_point(pr.(horv))
  vline(gp)
  if (nargout > 0)
    varargout{1} = mean_value;
  endif
  
  if (nargout > 1)
    varargout{2} = gp;
  endif
endfunction

function gp = gravity_point(pr_data)
  x = pr_data(:,1);
  y = pr_data(:,2);
  gp = sum(x.*y)/sum(y);
end
