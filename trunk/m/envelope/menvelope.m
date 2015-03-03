## -*- texinfo -*-
## @deftypefn {Function File} {@var{up}, @var{down} =} menvelope(@var{x}, @var{y}, @var{n})
## apply evelope @var{n} times.
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

function [up, down] = menvelope(x, y, n, varargin)
  [up, down] = envelope(x, y, varargin{:});
  n -= 1;
  if n >= 1
    [up, down_1] = menvelope(x, up, n, varargin{:});
    [up_1, down] = menvelope(x, down, n, varargin{:});
  endif
endfunction
