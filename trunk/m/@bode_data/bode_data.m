## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} bode_data(@var{tf})
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

function retval = bode_data(varargin)
  retval = struct("tf", NA, "params", NA, "f_in", NA);
  switch nargin
      case 0
        return;
      case 1
        if isa(varargin{1}, "bode_data")
          retval = varargin{1};
          return;
        else
          retval.tf = varargin{1};
        endif
      case 2
        retval.tf = varargin{1};
        retval.params = varargin{2};
      otherwise
         error("Wrong argument numbers");
     endswitch
    retval = class(retval, "bode_data");
endfunction

%!test
%! bode_data(x)
