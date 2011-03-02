## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} loop_Vp_Vn(@var{config})
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

function varargout = loop_Vp_Vn(varargin)
  if !nargin
    print_usage();
    return;
  endif
  
  result = loop_du_Vn(varargin{:});
  
  result.mag = result.mag.*result.Gp.*result.gp;
  if !nargout
    semilogx(result.w_norm,20*log10(result.mag));xlim([1e-2,1e2]);grid on;...
    ylabel("{/Symbol D}u / V_n [dB]");xlabel("{/Symbol w}/{/Symbol w}_s");
  elseif nargout == 3
    varargout = {result.mag, result.phase, result.w};
  else
    varargout = {result};
  endif
endfunction

%!test
%! loop_Vp_Vn(x)
