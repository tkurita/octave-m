## 
##=Parameters
## * sxRecords
##      .lattice
##      .brho
##      .isx1 -- sx1 の電流値
##      .isx2 -- sx2 の電流値
##      .isx3
##      .em.x -- x emittance 初期値
##      .em.y -- y emittance 初期値
##      .BMPeValues -- [BMPe1, BMPe2] の電流値
## * nParticles -- 粒子の数
## * nLoop -- 粒子をまわす回数
function [particlesAtESD, lastParicle, initialParticles] =\
  separatrixTracking(sxRecord, particleRecord, nLoop)
  ##== setup sextupole magnet
  if (isfield(sxRecord, "sxOption"))
    sxOption = sxRecord.sxOption;
  else
    sxOption = "3rd";
  endif
  sx1 = sextupoleSetting(sxRecord.brho, sxRecord.isx1, "SX1", sxOption);
  sx2 = sextupoleSetting(sxRecord.brho, sxRecord.isx2, "SX2", sxOption);
  sx3 = sextupoleSetting(sxRecord.brho, sxRecord.isx3, "SX3", sxOption);
  
  ##== setup BMPe
  if (!isfield(sxRecord, "BMPeValues"))
    sxRecord.BMPeValues = [0,0];
  endif
  BMPe1 = steererSetting(sxRecord, "BMPe1", sxRecord.BMPeValues(1));
  BMPe2 = steererSetting(sxRecord, "BMPe2", sxRecord.BMPeValues(2));
  
  # order of elements
  # ESI, SX1, SX2, BMPe1, ESD, BMPe2, SX3
  latArraySX = splitLattice(sxRecord.lattice, {"SX1", "SX2", "SX3"}, 0);
  # 1: ESD-SX1
  # 2: SX1-SX2
  # 3: SX2-BMPe1-ESD-BMPe2-SX3
  # 4: SX3-ESD
  latArrayBMPe = splitLattice(latArraySX{3}, {"BMPe1","BMPe2"}, 0);
  # 1:SX2-BMPe1
  # 2:BMPe1-ESD-BMPe2
  # 3:BMPe2-SX3
  latArrayESD = splitLattice(latArrayBMPe{2}, {"ESD"}, 1);
  # 1:BMPe1-ESD
  # 2:ESD-BMPe2
  
  matArraySX = totalMatForTrack(latArraySX);
  matArrayBMPe = totalMatForTrack(latArrayBMPe);
  matArrayESD = totalMatForTrack(latArrayESD);
  initialParticles = makeParticles(sxRecord.lattice{end}, particleRecord);
  particles = initialParticles;  
  particlesAtESD = [];
  for i = 1: nLoop
    particles = matArraySX{1}*particles;
    particles = sx1.kick(sx1, particles);
    particles = matArraySX{2}*particles;
    particles = sx2.kick(sx2, particles);
    particles = matArrayBMPe{1}*particles;
    particles = steererKick(BMPe1, particles);
    particles = matArrayESD{1}*particles;
    particlesAtESD = [particlesAtESD, particles];
    particles = matArrayESD{2}*particles;
    particles = steererKick(BMPe2, particles);
    particles = matArrayBMPe{3} * particles;
    particles = sx3.kick(sx3, particles);
    particles = matArraySX{4}*particles;
  endfor
  
  particles=particles(:,!isnan(particles(1,:))); #NaN の除去
  #particlesAtESD = particlesAtESD(:,!isnan(particlesAtESD(1,:)));
  
  lastParicle = particles(:,abs(particles(1,:)) < 1); #大きな振幅の粒子を除去
  #particlesAtESD = particlesAtESD(:,abs(particlesAtESD(1,:)) < 1);
  
endfunction
