## -*- texinfo -*-
## @deftypefn {Function File} {@var{pat_info} =} shift_qgl(@var{pat_info}, @var{shift_vec}, @var{level})
##
## @example
## 
## @end example
##
## @end deftypefn

##== History
##

function pat_info = shift_qgl(pat_info, shift_vec, level)
  pat_info.(["qf",level]) += shift_vec(1);
  pat_info.(["qd",level]) += shift_vec(2);
endfunction

%!test
%! shift_qgl(x)
