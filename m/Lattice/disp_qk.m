## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} disp_qk(@var{lattice})
## 
## print qfk and qdk
##
## @end deftypefn

##== History
## 2018-03-06
## * first implementaion

function varargout = disp_qk(latrec)
  qk.f = sprintf("qfk : %g", latrec.qfk);
  qk.d = sprintf("qdk : %g", latrec.qdk);
  if (nargout > 0)
    varargout = {[qk.f;qk.d]};
  else
    disp(qk.f);
    disp(qk.d);
  endif
endfunction
