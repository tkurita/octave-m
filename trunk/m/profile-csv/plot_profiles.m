## Usage : [fit_center, gravity_point]
##                  = plot_profiles(filelist, horv)
##
##
##= Parameters
##  * filelist -- a cell array of path to Profile Hold data and legend comment
##     e.g. {"../profile.csv", "comment", "../profile2.csv, "comment2"...}
##  * plot_title
##  * horv -- "h" or "v"
##
##= Result 
##  mean value of gaussian fit

##== History
## 2008-01-10
## * first implementation

function varargout = plot_profiles(filelist, horv)
  
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
