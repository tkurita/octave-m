## -- rfv = rfv_with_fs_mev(fs, KE_MeV, ps, particle, q, h, C, alpha)
##    Obtain RF voltage which give synchrtoron frequency and kinetic energy.
##
##  * Inputs *
##    rfv      : RF Voltage in [V]
##    KE_MeV   : Kinetic energy in [MeV]
##    ps       : 
##    particle : name of particle or mass number
##    q        : charge number
##    C        : cicumference in [m]
##    h        : harmonics
##    alpha    : momentum compaction factor
##
##  * Outputs *
##    Synchtoron freqyency in Hz
##    
##  * Exmaple *
##
##  See also: synchro_freq, fs_with_rfv_mev


function rfv = rfv_with_fs_mev(fs, KE_MeV, ps, particle, q, h, C, alpha)
  if ! nargin
    print_usage();
  endif
  
  lv = physical_constant("speed of light in vacuum"); # 光速
  m0c2 = mass_energy(particle)*1e6; # [eV]
  Ee2 = m0c2^2 + (KE_MeV*1e6).^2; # [ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2;
  cosphi = -cos(ps);
  omega_c = 2*pi*lv/C;
  ws = 2*pi*fs;
  rfv = ws.^2.*2.*pi.*Ee./(eta.*h.*omega_c.^2.*q.*cosphi);
endfunction

%!test
%! func_name(x)
