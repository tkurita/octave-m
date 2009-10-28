## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} qk_at_time(@var{gl_pattern}, @var{bl_pattern}, @var{t}, options)
## @deftypefnx {Function File} {@var{result} =} qk_at_time(@var{gl_pattern}, @var{brho}, t, options)
##
## Obtain qk [1/m*m] from @var{gl_pattern} at @var{t} [msec].
##
## Arguments
## 
## @table @code
## @item @var{gl_pattern}
## a pattern of the Q magnet
## @item @var{bl_pattern}
## a pattern of BL value of the Bending Magnet
## @item @var{brho}
## a Brho value. [T*m].
## @item @var{t}
## time [msec]
## @end table
##
## Options
##
## @table @code
## @item "porarity"
## 1 : focusing Q, -1 : defocusing Q @*
## if porarity is ommited, value is 1 ie. focusing Q is assumed.
## @item "qlength"
## efective length of Q magnet [m]
## @end table
##
## @end deftypefn

## Usage : qkValue = qk_at_time(gl_pattern, bl_pattern, t [, "property", value, ...])
## 
##== Parameters
## * gl_pattern -- a pattern of the Q magnet
## * bl_pattern -- a pattern of BL value of the Bending Magnet
## * t -- time [msec]
##
##== Optional properties
## * "porarity" -- if porarity is ommited, value is 1 ie. focusing Q is assumed.
##    * 1 : focusing Q
##    * -1 : defocusing Q
## * "qlength" -- efective length of Q magnet [m]
##
##== Result 
## [1/(m*m)]

##== To Do
## 2007-10-23
## * qlength を埋め込んでいるというのは汎用性が無い。
## * qlength で割り算するのをやめるか・・・
## * calc_lattice, process_lattice が 1/(m*m) を要求しているのが良くないか。

##== History
## 2008-07-25
## * renamed from QKValueAtTime
## * bl_pattern can be a scalar of Brho value.
## 
## 2006-11-22
## * optional arguments are given with "property"-value style.
## * add an optional argument "qlength"
##
## 2006-08-22
## * change qlength to 0.21 from 0.212
##

function qkValue = qk_at_time(gl_pattern, bl_pattern, t, varargin)
  # bl_pattern = BMPattern;
  # gl_pattern = QFPattern;
  # t = 700;
  if (iscell(bl_pattern))
    brho = BrhoAtTime(bl_pattern,t);
  else
    brho = bl_pattern;
  endif
  
  gl = value_at_time(gl_pattern,t);
  
  porarity = 1;
  #qlength = 0.15; #[m]
  #qlength = 0.212; #[m]
  qlength = 0.21; #[m]
  [porarity, qlength] = get_properties(varargin, {"porarity", "qlength"}, {1, 0.21});
  
  qkValue = porarity * gl/brho/qlength;
  
endfunction
