## Usage : [fit_center, gravity_point]
##                  = fit_profile(filepath, plot_title, horv, [ignore_bins", [1, 10]])
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
## 2026-05-29
## * add: support load_profile_csv supporting flags row
## * fix: ignoring multiple bins. rmoving small index bin causes invalid result
## 2008-07-02
## * use gaussianx instead of gaussian
##
## 2008-01-09
## * use load_profile_csv instead of loadProfileCVS
##
## 2007-12-03
## * update for 2.9.14

function varargout = fit_profile(filepath, plot_title, horv, varargin)
  opts = get_properties(varargin, {"ignore_bins", []});
  pr = load_profile_csv(filepath);
  prxy = pr.(horv);
  valid_limit = 3275; #3276 だと satulate しているみたい
  for n = 1:rows(prxy)
    if prxy(n,2) > valid_limit
      opts.ignore_bins(end + 1) = n;
    endif
  endfor
  
  for n = flip(sort(opts.ignore_bins))
    prxy(n,:) = [];
  endfor
  prxy(isnan(prxy(:,2)),:) = []; # remove NaN
  initial_values = [1000, 10, 0];
  fit_result_pr = gaussian_fit(prxy, initial_values);
  x_pr = prxy(:,1);
  bar(x_pr, prxy(:,2), 0.5);
  x = linspace(x_pr(1), x_pr(end), 100);
  mean_value = fit_result_pr(3);
  y = gaussianx(x, fit_result_pr(1), fit_result_pr(2), mean_value);
  hold on;
  plot(x, y, "-r", "linewidth", 2);
  hold off;
  vline(mean_value, "color", "magenta", "linewidth", 1);
  gp = gravity_point(prxy);
  vline(gp, "color", "green", "linewidth", 1);

  title(plot_title);
  xlabel("Position [mm]");
  ylabel("");
  axis("auto");
  grid on;
  if (nargout > 0)
    varargout{1} = mean_value;
  endif
  
  if (nargout > 1)
    varargout{2} = gp;
  endif

  if (nargout > 2)
    varargout{3} = pr.name;
  endif

endfunction

function gp = gravity_point(pr_data)
  x = pr_data(:,1);
  y = pr_data(:,2);
  gp = sum(x.*y)/sum(y);
end
