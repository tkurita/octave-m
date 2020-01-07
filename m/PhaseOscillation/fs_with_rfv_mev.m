## -- fs_Hz = fs_with_rfv_mev(rfv, KE_MeV, ps, particle, q, h, C, alpha)
##    Obtain synchrotoron frequency from RF Voltage and kinetic energy.
##
##  * Inputs *
##    rfv      : RF Voltage in [V]
##    KE_MeV   : Kinetic energy in [MeV]
##    ps       : 
##    particle : name of particle or mass number
##    q        : charge number
##    h        : harmonics
##    C        : cicumference in [m]
##    alpha    : momentum compaction factor
##
##  * Outputs *
##    Synchtoron freqyency in Hz
##    
##  * Exmaple *
##
##  See also: synchro_freq, rfv_with_fs_mev

function fs_Hz = fs_with_rfv_mev(rfv, KE_MeV, ps, particle, q, h, C, alpha)
  if ! nargin
    print_usage();
    return;
  endif

  lv = physical_constant("speed of light in vacuum"); #光速
  m0c2 = mass_energy(particle)*1e6; # [eV]
  # Ee2 = m0c2^2 + (KE_MeV*1e6).^2 .*lv^2; #[ev2]
  Ee2 = m0c2^2 + (KE_MeV*1e6).^2; #[ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2;
  cosphi = -cos(ps);
  omegaC = 2*pi*lv/C;
  ws = sqrt((eta .* h .* omegaC^2.*q.*rfv.*cosphi)./(2*pi.* Ee));
  fs_Hz = ws./(2*pi);
endfunction

%!test
%! func_name(x)
