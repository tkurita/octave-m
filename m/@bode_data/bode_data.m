## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} bode_data(@var{tf}, [@var{options}])
## @deftypefnx {Function File} {@var{obj} =} bode_data(@var{fh}, @var{params}, [@var{options}])
##
## Evaluate data of @var{tf} for bode diagram.
##
## @strong{Inputs}
## @table @var
## @item tf
## transfer function
## @item fh
## an function handle to generate a transfer function with parameters @var{params}
## @item params
## a structure to provide parameters of a transfer function.
## @end table
##
## @strong{Options Key}
## @table @code
## @item scale
## @item delay
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
## @strong{Examples}
## @example
## pkg load control
## 
## f = logspace(-1, 4, 500);
## bd = set_frequency(bode_data(tf([1], [0.01, 1])), f)
## subplot(2,1,1);
## xyplot(gain_10dB(bd))
## subplot(2,1,2);
## xyplot(phase(bd));
##  apply_to_axes("xscale", "log");
## 
## function retval = make_tf(X)
##    [Tc] = getfields(X, "Tc");
##    retval = tf([1], [Tc, 1]);
## end
##  
## bd2 = set_frequency(bode_data(@make_tf, struct("Tc", 0.01)), f);
## subplot(2,1,1);
## xyplot(gain_10dB(bd2))
## subplot(2,1,2);
## xyplot(phase(bd2));
## apply_to_axes("xscale", "log");
##
## @end example
## 
## @end deftypefn

function retval = bode_data(varargin)
  retval = struct("tf", NA, "params", NA, "f_in", NA, "response", NA);
  [args, opts] = parseparams(varargin);
  params = struct();
  switch length(args)
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
        params = varargin{2};
        retval.params = params
      otherwise
         error("Wrong argument numbers");
    endswitch
    
    if length(opts)
      params = join_struct(params, struct(opts{:}));
      retval.params = params;
    end
    retval = class(retval, "bode_data");
endfunction

%!test
%! bode_data(x)
