## deprecated recent octave forge hanve a function "physical_constant"
##
## = Parameters
## 
## * "light velocity"
## * "proton [MeV]"

function result = physicalConstant(constName)
  switch (constName)
    case "light velocity"
      result = 2.99792458e8; #[m/s] light velocity
    case "proton [MeV]"
      result = 938.271998; #[MeV] mass energy of proton
    case "proton [eV]"
      result = 938.271998*1e6; # proton static energy [eV]
    case "proton [Kg]"
      result = 1.6726231e-27; # proton mass [Kg]
    case "amu"
      result = 931.494043; #[MeV/c^2] 1 質量数の定義 12C の質量を 12 で割ったもの
    case "electron [Kg]"
      result = 9.1093897e-31; # electron mass [Kg]
    case "epsilon0"
      result = 8.854187817e-12; # 真空中の誘電率 [F/m]
    case "mu0"
      result = 12.566370614e-7; # 真空中の透磁率
    case "elementary charge"
      result = 1.6e-19; #素電荷 [C]
    case "classical electron radius"
      result = 2.818e-15 ;# classical electron radius radius [m]
  endswitch
endfunction
