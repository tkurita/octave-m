1; # script file
## define physical constants

#global lv  proton_MeV proton_Kg eC er ;

global lv = 2.99792458e8;
lv = 2.99792458e8 #[m/s] light velocity
##protonME = 938e6; #[eV]
global proton_MeV = 938.271998;
proton_MeV = 938.271998 # proton static energy [MeV]
global amu;
amu = 931.494043 #[MeV/c^2] 1 質量数の定義 12C の質量を 12 で割ったもの
#global proton_eV;
global proton_eV = proton_MeV*1e6 # proton static energy [eV]
global proton_Kg = 1.6726231e-27 # proton mass [Kg]
global electron_Kg = 9.1093897e-31 # electron mass [Kg]
global epsi0 = 8.854187817e-12 # 真空中の誘電率 [F/m]
global mu0 = 12.566370614e-7 # 真空中の透磁率
global eC = 1.6e-19; #素電荷 [C]
global er = 2.818e-15 ;# classical electron radius radius [m]
