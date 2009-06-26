## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

## usage : [formatedText =] disp_tune(@var)
##

##== History
## not implemented

function varargout = disp_tune(tune)
  tune.v_comment = sprintf("vertial ture:%g",tune.v);
  tune.h_comment = sprintf("horizontal ture:%g",tune.h);
  if (nargout > 0)
    varargout = {[tune.h_comment;tune.v_comment]};
  else
    printf("%s\n", tune.h_comment);
    printf("%s\n", tune.v_comment);
  endif
endfunction
