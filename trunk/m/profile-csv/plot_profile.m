## Usage : [fit_center, gravity_point]
##                  = plot_profile(filepath, plot_title, horv)
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
## 2008-01-09
## * not implemented

function varargout = plot_profile(filelist, horv)
  
  plot_arg = {};
  for n = 1:2:length(filelist)
    plot_arg{end+1} = load_profile_csv(filelist{n}).(horv);
    plot_arg{end+1} = ["-@;", filelist{n+1}, ";"];
    plot_arg{end+1} = "linewidth";
    plot_arg{end+1} = 2;
  endfor
  
  xyplot(plot_arg{:}); grid on; 
  xlabel("Position [mm]");
  ylabel("");
  
endfunction
