## -*- texinfo -*-
## @deftypefn {Function File} frev_with_momentum(@var{p}, @var{circumference}, @var{particle})
## Calculate revolution frequency [Hz] of a particle from its momentum.
## It is assumed that the harmonics is 1.
##
## @table @var
## @item p
## momentum [MeV/c]
## @item circumference
## circumference of the ring [m]
## @item particle
## kind of a particle, should be "proton" or "carbon" or mass number.
## @end table 
##
## @end deftypefn

##== History
## 2011-02-16
## * first implementaion

function result = frev_with_momentum(p, circumference, particle)
  if nargin < 3
    print_usage();
    return;
  endif
  v = velocity_with_momentum(p, particle);
  result = v/circumference;
endfunction

%!test
%! frev_with_mev(10, 33.201, "proton")