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
## 2008-07-02
## * use gaussianx instead of gaussian
##
## 2008-01-09
## * use load_profile_csv instead of loadProfileCVS
##
## 2007-12-03
## * update for 2.9.14

function varargout = fit_profile(filepath, plot_title, horv)
  pr = load_profile_csv(filepath);
  valid_limit = 3275; #3276 だと satulate しているみたい
  for n = 1:rows(pr.(horv))
    if pr.(horv)(n,2) > valid_limit
      pr.(horv)(n,2) = 0;
    endif
  endfor
  xyplot(pr.(horv), "-@;;");
  initial_values = [1000, 10, 0];
  fit_result_pr = gaussian_fit(pr.(horv), initial_values);
  mean_value = fit_result_pr(3);
  vline(mean_value);
  gp = gravity_point(pr.(horv));
  vline(gp);

  title(plot_title);
  xlabel("Position [mm]");
  ylabel("");
  axis("auto");

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
