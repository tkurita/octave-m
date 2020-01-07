## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} rfv_for_fs(@var{fs}, @var{particle}, @var{q}, @var{brho}, @var{h}, @var{ps}, @var{C})
## Obtain RF voltage which give synchrtoron frequency.
##
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

function retval = rfv_for_fs(fs, particle, q, brho, h, ps, C, alpha)
  if ! nargin
    print_usage();
  endif
  lv = physical_constant("speed of light in vacuum"); #光速
  m0c2 = mass_energy(particle)*1e6; #[eV]
  Ee2 = m0c2^2 + brho.^2 .*lv^2; #[ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2;
  cosphi = -cos(ps);
  omega_c = 2*pi*lv/C;
  ws = 2*pi*fs;
  retval = ws^2*2*pi*Ee/(eta*h*omega_c^2*q*cosphi);
endfunction

%!test
%! func_name(x)
