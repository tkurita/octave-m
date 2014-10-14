## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} func_name(@var{arg})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
##

function [up, down] = menvelope(x, y, n, method)
  [up, down] = envelope(x, y, method);
  n -= 1;
  if n >= 1
    [up, down_1] = menvelope(x, up, n, method);
    [up_1, down] = menvelope(x, down, n, method);
  endif
endfunction
