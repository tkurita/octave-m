## -*- texinfo -*-
## @deftypefn {Function File} {@var{ke} =} mev_with_brho_pattern(@var{brhos}, @var{emin}, @var{emax}, @var{particle})
## @deftypefnx {Function File} {@var{retval} =} mev_with_brho_pattern(@var{brhos}, @var{emin}, @var{emax}, @var{AMU}, @var{charge})
##
## The maiximum and minimum of @var{brhos} are scaled to match 
## with B*rho for @var{emax} and @var{emin}. And the scaled @var{brhos} 
## are converted in to the equivalent kinetic envery.
##
## @strong{Inputs}
## @table @var
## @item brhos
## A list of B*rho values.
## @item emin
## The minimum enery in MeV.
## @item emax
## The maximum energy in MeV.
## @end table
##
## @strong{Outputs}
## @table @var
## @item ke
## A list of kinetic energy which is equivalent to the scaled @var{brho}.
## @end table
##
## @end deftypefn

##== History
## 2012-10-25
## * improved documentation.
##
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
