## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} mev_with_brho_pattern(@var{bline}, @var{emin}, @var{emax}, @var{particle})
## @deftypefnx {Function File} {@var{retval} =} mev_with_brho_pattern(@var{bline}, @var{emin}, @var{emax}, @var{AMU}, @var{charge})
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
## 2011-01-26
## * First implementation

function retval = mev_with_brho_pattern(brhos, emin, emax, varargin)
  brho_min = brho_with_mev(emin, varargin{:});
  brho_max = brho_with_mev(emax, varargin{:});
  bmin = min(brhos);
  bmax = max(brhos);
  brhos = brhos*(brho_max - brho_min)/(bmax-bmin);
  brhos = brhos + (brho_min - min(brhos));
  retval = mev_with_brho(brhos, varargin{:});
endfunction

%!test
%! func_name(x)
