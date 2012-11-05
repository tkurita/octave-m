## usage : result = mass_energy(particle)
##  resolve rest mass enery [MeV]
##
##== Parameter
## * particle -- "proton" or "carbon" or "helium" or mass number [amu]

##== History
## 2012-11-05
## * change names due to specification chages of physical_constant.
## 2008-02-26
## * Use physical_constant intead of physicalConstant.
## * mass_energy can accelpt mass number

function result = mass_energy(particle)
  if (nargin < 1)
    usage();
  endif
  
  if (isnumeric(particle))
    switch particle
      case 1
        result = physical_constant("proton mass energy equivalent in MeV");
      case 2
        result = physical_constant("deuteron mass energy equivalent in MeV");
      case 4
        result = physical_constant("alpha particle mass energy equivalent in MeV");
      otherwise
        amu = physical_constant("atomic mass constant energy equivalent in MeV");
        result = amu * particle;
    endswitch
  else
    switch particle
      case "proton"
        result = physical_constant("proton mass energy equivalent in MeV");
      case "helium"
         result = physical_constant("alpha particle mass energy equivalent in MeV");
      case "carbon"
        amu = physical_constant("atomic mass constant energy equivalent in MeV");
        result = amu *12;
      otherwise
        error("\"%s\" is unknown particle specifier.", particle);
    endswitch
  endif
   
endfunction