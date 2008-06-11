## -*- texinfo -*-
## @deftypefn {Function File} {[@var{hit_history}, @var{monitor_history}] =} distill_history_from_files(@var{location}, @var{monitors})
##
## @end deftypefn

##== History
##

function [hit_history, monitor_history] = distill_history_from_files(location, monitors)
  # location = "tracklog";
  [status, out] = system(["find -E ",location," -regex \".*/[0-9]+\\.mat\""]);
  filelist = splitreg(out, "\\n");
  # filelist = filelist(1:3);
  if (nargin < 2)
    monitors = {};
  endif
  
  for n = 1:length(filelist)
    pre_time = time;
    load(filelist{n});
    printf("spend time to load %s : %d [sec]\n",filelist{n}, time - pre_time);
    pre_time = time;
    if (n == 1)
      for m = 1:length(monitors)
        monitor = monitors{m};
        monitor_history.(monitor) = distill_history(particle_hist.monitors.(monitor));
      endfor
      hit_history = arrange_hits(particle_hist);
    else
      for m = 1:length(monitors)
        monitor = monitors{m};
        monitor_history.(monitor) = append_history(monitor_history.(monitor), particle_hist.monitors.(monitor));
      endfor
      hit_history = arrange_hits(hit_history, particle_hist);
    endif
    printf("spend time to arranging and appending : %d [sec]\n",time - pre_time);
  end
endfunction