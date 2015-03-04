## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} incoherent_tune_shift(@var{dist}, @var{R}, @var{gm}, @var{nu}, @var{N}, @var{em}, [@var{Bf}, @var{sef}])
##
## Incoherent tune shift by space charge effect.
##
## @table @samp
## @item @var{dist_type}
## "uniform" or "gaussian"
##
## @item @var{R}
## mean radius of the ring [m]
##
## @item @var{gm}
## (total every)/(energy of static mass)
##
## @item @var{nu}
## a vector of tune [tune_x, tune_y].
##
## @item @var{N}
## Number of particles
##
## @item @var{em}
## a vector of emittance [em_x, em_y]. [pi m rad]
##
## @item @var{Bf}
## bunching fuctor typicaly 0.3.
##
## @item @var{sef}
## scaling factor to obtain standard deviation of charge density from emmitance.
## @var{sef} * s = @var{em};
## @end table
##
## @end deftypefn

##== History
## 2010-09-10
## * First implementaion

function retval = incoherent_tune_shift(dist, R, gm, nu, N, em, Bf, varargin)
  beta2 = 1- 1/(gm^2);
  rp = 1.5305e-18; # protorn classical radius [m]
  switch dist
    case "uniform"
      sef = sqrt(2);
    case "gaussian"
      if length(varargin) > 0
        sef = varargin{1};
      else
        sef = 2;
      endif
  endswitch
  betaf = R./nu;
  sig = sqrt(em.*betaf)./sef;
  retval = ...
    [-N*rp*betaf(1)/(2*pi*beta2*gm^3*Bf*sig(1)*(sig(1)+sig(2))),...
    -N*rp*betaf(2)/(2*pi*beta2*gm^3*Bf*sig(2)*(sig(2)+sig(1)))];
endfunction

%!test
%! func_name(x)
