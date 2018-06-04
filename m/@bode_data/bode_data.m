## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} bode_data(@var{tf}, [@var{option}])
##
## Evaluate data of @var{tf} for bode diagram.
##
## @strong{Inputs}
## @table @var
## @item tf
## transfer function
## @end table
##
## @strong{Options Key}
## @table @code
## @item scale
## @item InputDelay
## @end table
## 
## @strong{Outputs}
## @table @var
## @item obj
## bode_data object
## @end table
##
## @strong{methods}
## @table @code
## @item gain
## @item phase
## @item gain_10dB
## @item set_frequency
## @end table
## 
## @end deftypefn

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
