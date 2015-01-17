## -*- texinfo -*-
## @deftypefn {Function File} {@var{ps}, @var{sin_ps} =} synchro_phase(@var{bl}, @var{tline}, @var{vline}, @var{C})
## Calculate of phase of synchronous particle.
## 
## @strong{Inputs}
## @table @var
## @item brho
## BM pattern in BL [T*m]
## @item tline
## list of time in [ms]
## @item vline
## RF voltage pattern [V]
## @item C
## circumference [m], 33.201 mm for WERC
## @end table
##
## @strong{Outputs}
## @table @var
## @item ps
## phase angle in [rad].
## always in 0 to pi/2 ignoring below and above transition.
## @item sin_ps
## sin(ps)
## @end table
##
## @end deftypefn

##== History
## 2011-01-25
## * accept Brho instead of BL -- not correct
## * help with texinfo
## 2010-12-21
## * renamed from synchronusRFPhase
## * fixed for Octave 3.2
##
## 2009-10-30
## * It looks that gradient(tline/1000) is needed. gradient was changed ?

function [ps,sin_ps] = synchro_phase(bl, tline, vline, C)
  # C = 33.201
  # A charge number as a parameter is not required,
  # because it is cancled between bl and vline.
  dbdt=gradient(bl, (tline/1000));
  sin_ps = (C*dbdt/(pi/4))./vline;
  sin_ps(isnan(sin_ps)) = 0;
  ps =asin(sin_ps);
endfunction
