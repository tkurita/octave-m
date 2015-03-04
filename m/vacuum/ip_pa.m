## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function retval = ip_pa(varargin)
  retval = ip_pa_with_amp(varargin{:});
endfunction

%!test
%! func_name(x)
