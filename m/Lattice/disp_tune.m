## usage : [formatedText =] disp_tune(tune)
##

##== History
## 2008-08-01
## * renamed from printTune

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
