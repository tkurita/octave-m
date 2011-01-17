## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function plot_tune_spread(R, gm, nu, N, em, Bf, sef)
  betaf = R./nu;
  sig = sqrt(em.*betaf)./sef;
  jac_max = em/2;
  dnu2 = [];
  for jac_x = linspace(0, jac_max(1), 100)
    for jac_y = linspace(0, jac_max(2), 100)
      jac = [jac_x, jac_y];
      dnu2(end+1, :) = [dnu_second(N, gm, Bf, betaf, sig, jac),...
          dnu_second(N, gm, Bf, fliplr(betaf), fliplr(sig), fliplr(jac))];
    endfor
  endfor
  jac = [jac_max(1), 0]
  dnu2_1 = [dnu_second(N, gm, Bf, betaf, sig, jac),...
      dnu_second(N, gm, Bf, fliplr(betaf), fliplr(sig), fliplr(jac))];
  jac = [0, jac_max(2)]
  dnu2_2 = [dnu_second(N, gm, Bf, betaf, sig, jac),...
      dnu_second(N, gm, Bf, fliplr(betaf), fliplr(sig), fliplr(jac))];
  ajac = jac_max;
  dnu2_2 = [dnu_second(N, gm, Bf, betaf, sig, jac),...
      dnu_second(N, gm, Bf, fliplr(betaf), fliplr(sig), fliplr(jac))];

  dnu1 = incoherent_tune_shift("gaussian", R, gm, nu, N, em, Bf, sef);
  nus = nu+dnu1;
  xyplot(nu, "@", nus, "@", repmat(nus, rows(dnu2), 1)+dnu2, "@", nus+dnu2_1, "x", nus+dnu2_2, "x")
endfunction

%!test
%! L = 33.2; # [m] 周長
%! R  = L/(2*pi);
%! Bf = 0.3 # bunching factor
%! T = 10 ; # kinetic energy [MeV]
%! nM = 1; # mass number [a.m.u.]
%!
%! eC = physical_constant("ELEMENTARY_CHARGE");
%! protonMeV = physical_constant("PROTON_MASS_ENERGY_EQUIVALENT_IN_MEV");
%! totalEnergy = T + nM*protonMeV;
%! gm = (totalEnergy)/(nM*protonMeV);
%!
%! nu_x = 1.69031798766018;
%! nu_y = 0.805410536307546;
%! nu = [nu_x, nu_y];
%!
%! ex = 378e-6; # [pi m rad]
%! ey = 33e-6 # [pi m rad]
%! em = [ex, ey];
%!
%! N = 30e-9/eC;
%!
%! sef = 2;
%! plot_tune_spread(R, gm, nu, N, em, Bf, sef)
