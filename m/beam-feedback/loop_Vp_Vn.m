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
    w_norm = result.w_norm;
    ax = plotyy(w_norm, 20*log10(result.mag) ...
            , w_norm, result.phase, @semilogx, @semilogx); grid on;...
    apply_to_axes("xlim", [1e-2,1e2]);
    ylim(ax(1), [-60, 10]);
    ylim(ax(2), [-185, 185]);
    ylabel(ax(1), "V_p / V_n [dB]");
    ylabel(ax(2), "phase [degree]");...
    xlabel("\\omega / \\omega_s");
  elseif nargout == 3
    varargout = {result.mag, result.phase, result.w};
  else
    varargout = {result};
  endif
endfunction

%!test
%! loop_Vp_Vn(x)
