## -*- texinfo -*-
## @deftypefn {Function File} frev_with_mev(@var{mev}, @var{circumference}, @var{particle})
## Calculate revolution frequency [Hz] of a particle from its energy.
## It is assumed that the harmonics is 1.
## @table @code
## @item @var{mev}
## kinetic energy [MeV]
## @item @var{circumference}
## circumference of the ring [m]
## 
## @item @var{partivle}
## kind of a particle, should be "proton" or "carbon" or mass number.
## @end table 
##
## @end deftypefn

##== History
## 2008-03-03
## * renamed from frevForMeV

function result = frev_with_mev(mev, circumference, particle)
  v = velocity_with_meV(mev, particle);
  result = v/circumference;
endfunction

%!test
%! frev_with_mev(10, 33.201, "proton")