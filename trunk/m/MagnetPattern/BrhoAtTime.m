## usage : brho = BrhoAtTime(blPattern,t)
##
## = Parameters
## * blPattern
## * t -- time [msec] or a structure which have 'time' field.
##
## = Result
## brho -- [T*m]

function brho = BrhoAtTime(blPattern,t)
  if (isstruct(t))
    if (isfield(t, "time"))
      t = t.time;
    else
      error ("The structure of second argument must have 'time' field");
    endif
  endif
  
  bl = BValueAtTime(blPattern,t);
  ## BL 積が出射エネルギーの Brho と一致しないので、
  ## 一致させるために、factor 1.0.1 で割る。
  brho = bl/(pi/4)/1.01; 
endfunction