## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} frequency_response(@var{sys})
## @deftypefnx {Function File} {@var{retval} =} frequency_response(@var{sys}, @var{w})
## 
## Evaluate frequency response
##
## @strong{Inputs}
## @table @var
## @item sys
## transfer function
## @item w
## frequency 
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function X = frequency_response(varargin)
  [reg, prop] = parseparams(varargin);
  X = reg{1};
  if length(reg) < 2
    if ! isna(X.response)
      #H = X.response;
      return
    end
    if isna(X.f_in)
      error("Frequency is not provided.");
    end
    w = 2*pi*X.f_in;
  else
    w = reg{2};
  end
  
  [a_tf, params] = eval_tf(X, prop{:});
  
  [num, den] = tfdata(a_tf, "vector");
  s = i * w; # continuous system
  H = polyval(num, s) ./ polyval(den, s);
  if isfield(params, "delay")
    H = H.*exp(-X.params.delay*s);
  end
  X.response = H;
endfunction

%!test
%! func_name(x)
