## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} frame_spectrum_at(@var{specdata}, @var{opts})
##
## @table @code
## @item "x"
## "MHz" or "Hz". Must be a field field name of @var{specdata}.
## The default is "MHz"
## @item "frame"
## 1 based index number of frame to get.
## @item "time"
## time of the frame to get. One of "frame" or "time" option can be used.
## @end table
## @end deftypefn

##== History
## 2009-06-05
## * To pass options key-value pair form is used.
## * accept time to speccify frame.
##
## 2009-06-02
## * Renamed from getFrame

function [result] = frame_spectrum_at(specdata, varargin)
  if (!nargin)
    print_usage();
  endif
  
  opts = get_properties(varargin,...
                        {"x", "frame", "time"},...
                        {"MHz", NA, NA});
  
  if (isna(opts.frame))
    if (isna(opts.time))
      error("One of \"frame\" or \"time\" options is required.");
    else
      if ((opts.time < specdata.msec(1)) || (opts.time > specdata.msec(end)))
        error(sprintf("time %f is out of range.", opts.time));
      endif
      ind = find(specdata.msec >= opts.time)(1);
      if (ind > 1)
        if (abs(opts.time-specdata.msec(ind)) > abs(opts.time-specdata.msec(ind-1)))
          ind -= 1;
        endif
      endif
      frameindex = ind;
    endif
  else
    frameindex = opts.frame;
  endif
                          
  x = specdata.(opts.x);
  y = specdata.dBm(frameindex, :);  
  result = [x(:), y(:)];
endfunction