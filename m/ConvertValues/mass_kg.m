## usage : result = mass_kg(particle)
##  resolve mass of the particle in kg
##
##== Parameter
## * particle -- "proton" or "carbon" or "helium" or mass number [amu]

function result = mass_kg(particle)
  if (nargin < 1)
    usage();
  endif
  
  if (isnumeric(particle))
    switch particle
      case 1
        result = physical_constant("proton mass");
      case 2
        result = physical_constant("deuteron mass");
      case 4
        result = physical_constant("alpha particle mass");
      otherwise
        amu = physical_constant("atomic mass constant");
        result = amu * particle;
    endswitch
  else
    switch particle
      case "proton"
        result = physical_constant("proton mass");
      case "helium"
         result = physical_constant("alpha particle mass");
      case "carbon"
        amu = physical_constant("atomic mass constant");
        result = amu *12;
      otherwise
        error("\"%s\" is unknown particle specifier.", particle);
    endswitch
  endif
   
endfunction