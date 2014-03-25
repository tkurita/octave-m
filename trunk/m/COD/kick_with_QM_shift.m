## -*- texinfo -*-
## @deftypefn {Function File} {@var{kick_angle} =} kick_with_QM_shift(@var{element}, @var{shift_val}, @var{horv})
## description
## @strong{Inputs}
## @table @var
## @item element
## a stucture of Q Magnet.
## @item shift_val
## alignment error of the QM in mm
## @item horv
## "h" : horizontal or "v" : vertical
## @end table
##
## @strong{Outputs}
## @table @var
## @item kick_angle
## kick angle in radian
## @end table
## 
## @seealso{}
## @end deftypefn

##== History
## 2014-03-25
## * renamed from kickAngleWithQShift

function ka = kick_with_QM_shift(element, shift_val, horv)
  in_vec = [-1*shift_val/1000; 0; 0];
  out_vec = element.mat.(horv) * in_vec;
  ka = out_vec(2);
endfunction