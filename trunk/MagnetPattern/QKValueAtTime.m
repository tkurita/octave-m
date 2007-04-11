## Useage : qkValue = QKValueAtTime(glPattern, blPattern, t [, "property", value, ...])
## 
## = Parameters
## * glPattern -- a pattern of the Q magnet
## * blPattern -- a pattern of BL value of the Bending Magnet
## * t -- time [msec]
##
## = Optional properties
## * "porarity" -- if porarity is ommited, value is 1 ie. focusing Q is assumed.
##    * 1 : focusing Q
##    * -1 : defocusing Q
## * "qlength" -- efective length of Q magnet [m]

## = History
## * 2006.11.22
##  optional arguments are given with "property"-value style.
##  add an optional argument "qlength"
## * 2006.08.22
##  change qlength to 0.21 from 0.212
##

function qkValue = QKValueAtTime(glPattern, blPattern, t, varargin)
  brho = BrhoAtTime(blPattern,t);
  gl = BValueAtTime(glPattern,t);
  
  porarity = 1;
  #qlength = 0.15; #[m]
  #qlength = 0.212; #[m]
  qlength = 0.21; #[m]
  
  n = 1;
  while (n <= length(varargin))
    switch (varargin{n})
      case ("porarity")
        porarity = varargin{++n};
      case ("qlength")
        qlength = varargin{++n};
    endswitch
    n++;
  endwhile
  qkValue = porarity * gl/brho/qlength;
  
endfunction
