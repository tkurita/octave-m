## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} dp_p_with_frevs(@var{f0}, @var{f1}, @var{a}, @var{C}, @var{particle})
## Obtain energy difference in MeV between @var{f0} and @var{f1}
## @strong{Inputs}
## @table @var
## @item f0
## Base frequency in Hz
## @item f1
## A frequency [Hz] varing from @var{f0}. f1 = f0 + df
## @item a
## momentum compaction factor.
## @item C
## circumference in [m]
## @item particle
## The kind of a particle.  "proton", "helium", "carbon" or mass number.
## @end table
##
## @strong{Outputs}
## dE [MeV] = - 1/(a - 1/g^2) df/f0 b^2 E0
## 
## @end deftypefn

##== History
## 2015-01-23
## * first implementataion

function retval = dE_with_frevs(f0, f1, a, C, particle)
  if (!nargin)
    print_usage();
    return;
  endif
  lv = physical_constant("speed of light in vacuum");
  v = C.*f0;
  b = v/lv;
  g = 1./sqrt(1-b.^2);
  df = f1 -f0;
  E0 = mev_with_frev(f0, C, particle) + mass_energy(particle);
  retval = - df.*E0.*(b.^2)./(f0.*(a - 1/(g.^2)));
endfunction

%!test
%! dE_with_frevs(x)
