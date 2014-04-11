## -*- texinfo -*-
## @deftypefn {Function File} {[@var{ws}, @var{Ee}, @var{eta} =} synchro_freq(@var{alpha}, @var{particle}, @var{brho}, @var{h}, @var{sin_ps}, @var{vline}, @var{C})
## Calculate syncrotron frequency.
##
## @strong{Inputs}
## @table @var
## @item alpha
## momentum compaction factor
## @item particle
## mass number or "proton", "helium", "carbon".
## @item brho
## BM pattern in [T*m]
## @item h
## harmonic number
## @item sin_ps
## sin(ps), ps : the RF phase angle of synchronus particle.
## @item vline
## RF voltage pattern in [V]
## @item C
## circumference [m]
## @end table
##
## @strong{Outputs}
## @table @var
## @item ws
## sinchrotoron frequency in [rad/sec]
## @item Ee
## total energy evaluated from @var{brho}
## @item eta
## alpha - 1/gamma^2 
## @end table
##
## @end deftypefn

##== History
## 2014-04-11
## * support new physical_constant
## 2011-01-25
## * accept brho instead of BL
## * help with texinfo.
## 2010-12-21
## * renamed from synchroFrequency

function [ws,Ee,eta] = synchro_freq(alpha, particle, brho, h, sin_ps, vline,C)
  lv = physical_constant("speed of light in vacuum"); #光速
  m0c2 = mass_energy(particle)*1e6; #[eV]
  Ee2 = m0c2^2 + brho.^2 .*lv^2; #[ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2; #
  cosphi = - sqrt(1 - sin_ps.^2);
  omegaC = 2 * pi*lv/C;
  ws = sqrt((eta .* h .* omegaC^2 .*vline .* cosphi)./(2 * pi .* Ee));
endfunction
