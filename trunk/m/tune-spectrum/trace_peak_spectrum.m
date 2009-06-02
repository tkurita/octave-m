## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} trace_peak_spectrum(@var{arg})
##
## @end deftypefn

##== History
## 2009-06-02
## * First implementation

function retval = trace_peak_spectrum(specdata, f, fwidth, varargin)
  #  starttime = 30
  #  f = 1.32
  #  fwidth = 0.03
  # varargin = {"starttime", 30}
  opts = get_properties(varargin, {"starttime", "endtime"},...
                        {specdata.msec(1), specdata.msec(end)});
  sindex = find(specdata.msec >= opts.starttime)(1);
  eindex = find(specdata.msec >= opts.endtime)(1);
  flist = [];
  prey = NaN;
  for n = sindex:eindex
    # n = sindex
    xy = frame_spectrum_at(specdata, n, "MHz");
    #  xyplot(xy)
    maxxy = ymax(xy, "xrange", [f-fwidth, f+fwidth]);
    if (isnan(prey))
      prey = maxxy(2);
    else
      if (abs(maxxy(2)) < abs(prey*0.7))
        flist(end+1,:) = [NaN, specdata.msec(n), n];
        continue;
      endif
    endif
    f = maxxy(1);
    flist(end+1,:) = [f, specdata.msec(n), n];
    prey = maxxy(2);
  endfor
  retval = flist;
endfunction

%!test
%! trace_peak_spectrum(x)
