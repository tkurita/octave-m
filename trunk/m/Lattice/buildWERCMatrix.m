## usage: all_elements = buildWERCMatrix(qfk,qdk,[vedge] )
##
## WERC シンクロトロンの全要素の matrix の配列を返す。
##
##= Parameters
## * qfk -- Q lens の長さをかけると、QF の収束力 [1/(m*m)]
## * qfd -- Q lens の長さをかけると、QD の収束力 [1/(m*m)]
## * vedge -- vertical edge effect of Bending Magnet
##            optional, default value is 0.24
##
##= Result
## cell array of structures which have following fields
##  * .len : 長さ
##  * .name : 名前
##  * .mat.h : 横方向の matrix 3×3
##  * .twmat.h : 横方向の twiss parameter を計算する matrix
##  * .mat.v : 縦方向の matrix 3×3
##  * .twmat.v : 縦方向の twiss parameter を計算する matrix

##== History
## 2007-10-18
## * accept a structure as an argument

function all_elements = buildWERCMatrix(varargin)
  if (isstruct(varargin{1}))
    lattice_rec = varargin{1};
    qfk = lattice_rec.qfk;
    qdk = lattice_rec.qdk;
    if (isfield(lattice_rec, "vedge"))
      vedge = lattice_rec.vedge;
    else
      vedge = 0;
    endif
  else
    qfk = varargin{1};
    qdk = varargin{2};
    if (length(varargin) > 2)
      vedge = varargin{3};
    else
      #vedge = 0.24;
      vedge = 0;
    endif
  endif
      
  ##== properties of bending magnet
  bmangle = (45/360)*2*pi;
  efflen = 1.57395;
  #bmradius = bmEffectiveLength/bmangle;
  radius = 1.91;
  #edgeangle = 0.75*2*pi/360;
  edgeangle = 1.5*pi/180;
  bmprop = tars(bmangle, radius, efflen, edgeangle, vedge);
   
  ##== properties of Q lens
  qlength.len = 0.15; #length of q magnet [m]
  #qlength.efflen = 0.212;
  qlength.efflen = 0.21;
  
  ##== Duct サイズ
  ## xmax, xmin, ymax, ymin
  ## xmax(-xmin), ymax(-ymin)
  ## radius
  ## 
  bmDuct = [63e-3, -58e-3, 23e-3, -23e-3];
  bpmDuct = [81e-3, -81e-3, 26e-3, -26e-3];
  qfDuct = [148e-3/2, (42.7-6)*1e-3/2];
  MRD1= qfDuct;
  MRD2 = [126e-3/2, (45-6)*1e-2/2];
  MRD3 = 1e-3*(114.3-6)/2;
  MRD4 = [1e-3*(136-2*26)/2,52e-3/2]; #絶縁ダクト BMP用?
  MRD5 = 1e-3*(139.8-6)/2;
  MRD6 = qfDuct;
  MRD7 = MRD5;
  MRD8 = [92e-3/2, 1e-3*(60.5-6)/2];
  MRD9 = [103e-3, -76e-3, 14e-3, -14e-3];
  MRD10 = [92e-3/2, 1e-3*(60.5-6)/2];
  MRD11 = 1e-3*(139.8-2*3.4)/2;
  MRD12_1 = 1e-3*(139.8-2*3.4)/2;
  MRD12_2 = qfDuct;
  MRD13 = MRD5;
  MRD14 = MRD4; #絶縁ダクト
  MRD15 = MRD3;
  ESD_Duct = [(58e-3)-(0.3e-3), -197.2e-3/2, 197.2e-3/2, -197.2e-3/2];
  FCTDuct = 133e-3/2;
  RFK_Duct = 200e-3/2;
  SM_Duct = [135.1e-3/2, 46e-3/2];
  RFK_Electrode = [140e-3/2, 38e-3/2];
  RFC_Duct = [146e-3/2];
  all_elements = {
  DT(0.2250,"ESI", [61.2e-3, -77e-3, 77e-3, -77e-3]),
  DT(0.1750, "MRD1-in", MRD1),
  QF(qfk,qlength,"QF1", MRD1),
  DT(0.15, "MRD1-out", MRD1),
  DT(0.1375,"DBPM1-in", bpmDuct),
  DT(0,"STH1", bpmDuct),
  DT(0,"BPM1", bpmDuct),
  DT(0.1375,"DBPM1-out",bpmDuct),
  DT(0.230,"DPR1-in", [176e-3/2]),
  DT(0,"PR1", [176e-3/2]),
  DT(0.2, "DPR1-out",[176e-3/2]);  
  DT(0.445,"MRD2-in", MRD2),
  DT(0.20,"SX1", MRD2),
  DT(0.125, "MRD2-out", MRD2),
  DT(0.175, "BMD1-in", bmDuct),
  BM(bmprop, "BM1", bmDuct),
  DT(0.175, "BMD1-out", bmDuct),
  DT(0.1675,"FCT", FCTDuct),
  DT(0.2125,"DFCT-out", FCTDuct),
  DT(0.1450,"MRD3-in", MRD3),
  QD(qdk,qlength,"QD1", MRD3),
  DT(0.13, "MRD3-out", MRD3),
  DT(0.07, "MRD4-in", MRD4),
  DT(0.2, "BMPi1", MRD4),
  DT(0.125, "MRD4-out", MRD4),
  DT(0.175, "BMD2-in", bmDuct),
  BM(bmprop, "BM2", bmDuct),
  DT(0.175, "BMD2-out", bmDuct),
  DT(0.35, "MRD5", MRD5),
  DT(0.1375, "DBPM2-in", bpmDuct),
  DT(0, "STH2", bpmDuct),
  DT(0, "BPM2", bpmDuct),
  DT(0.1375, "DBPM2-out", bpmDuct),
  DT(0.16, "RFK-Duct", RFK_Duct),
  DT(0.2, "RFK-H", RFK_Electrode),
  DT(0.16, "RFK-V", RFK_Electrode),
  DT(0.3, "CT", (133e-3)/2),
  DT(0.18, "MRD6-in", MRD6),
  QF(qfk,qlength,"QF2", MRD6),
  DT(0.245,"MRD6-out", MRD6),
  DT(0.22,"DSCR-in", 220e-3/2),
  DT(0.06,"SCR-H", [68e-3, -68e-3, 203e-3/2, -203e-3/2]),
  DT(0.025, "DSCR", 203e-3/2),
  DT(0.005, "SCR-V", [152e-3/2, -152e-3/2, 17.5e-3, -17.5e-3]),
  DT(0.140, "DSCR-out", 152e-3/2),
  DT(0.155,"L11_1", MRD7),
  DT(0.3,"STV1", MRD7),
  DT(0.13,"L11_2", MRD7),
  DT(0.2,"SX2", MRD7),
  DT(0.145,"L12", MRD7),
  DT(0.175, "BMD3-in", bmDuct),
  BM(bmprop, "BM3", bmDuct),
  DT(0.175, "BMD3-out", bmDuct),
  DT(0.125,"L1A", MRD8),
  DT(0.2,"BMPe1", MRD8),
  DT(0.2,"L13", MRD8),
  QD(qdk,qlength,"QD2", MRD8),
  DT(0.25,"L14", MRD8),
  DT(0.1375,"BPM3-in", bpmDuct),
  DT(0,"STH3", bpmDuct),
  DT(0,"BPM3", bpmDuct),
  DT(0.1375,"DBPM3-in", bpmDuct),
  DT(0.175, "BMD4-in", bmDuct),
  BM(bmprop, "BM4", bmDuct),
  DT(0.175, "BMD4-out", bmDuct),
  DT(0.195, "L16", 197.2e-3/2),
  DT(0.9, "ESD", ESD_Duct),
  DT(0.385, "ESD-Chamber", ESD_Duct),
  DT(0.145, "MRD9-in", MRD9),
  QF(qfk, qlength, "QF3", MRD9),
  DT(0.22, "MRD9-out", MRD9),
  DT(0.63, "SM-in", SM_Duct),
  DT(0.5, "SM", SM_Duct),
  DT(0.1375, "DBPM4-in", bpmDuct),
  DT(0, "STH4", bpmDuct),
  DT(0, "BPM4", bpmDuct),
  DT(0.1375, "DBPM4-out", bpmDuct),
  DT(0.175, "BMD5-in", bmDuct),
  BM(bmprop, "BM5", bmDuct),
  DT(0.175,"BMD5-out", bmDuct),
  DT(0.1975,"L20_2", [143.2e-3/2]),
  DT(0, "PR2", [143.2e-3/2]),
  DT(0.2025, "DPR2-out", [143.2e-3/2]),
  DT(0.125, "MRD10-in", MRD10),
  QD(qdk,qlength,"QD3", MRD10),
  DT(0.2,"MRD10-middle", MRD10),
  DT(0.2,"BMPe2", MRD10),
  DT(0.125,"MRD10-out", MRD10),
  DT(0.175,"BMD6-in", bmDuct),
  BM(bmprop, "BM6", bmDuct),
  DT(0.175, "BMD6-out", bmDuct),
  DT(0.1375,"DBPM7-in", bpmDuct),
  DT(0,"BPM7", bpmDuct),
  DT(0.1375,"DBPM7-out",bpmDuct),
  DT(0.25,"DRFC-in", RFC_Duct),
  DT(0.6,"RFC", RFC_Duct),
  DT(0.05, "DRFC-out", RFC_Duct),
  DT(0.315,"MRD12-1-in", MRD12_1),
  DT(0.135, "MRD12-2-in", MRD12_2),
  QF(qfk,qlength,"QF4", MRD12_2), 
  DT(0.15, "MRD12-out", MRD12_2),
  DT(0.1375,"DBPM5-in", bpmDuct),
  DT(0,"BPM5", bpmDuct),
  DT(0,"STH5", bpmDuct),
  DT(0.1375,"DBPM5-out",bpmDuct),
  DT(0.855,"MRD13-in", MRD13),
  DT(0.2,"SX3", MRD13),
  DT(0.145,"MRD13-out", MRD13),
  DT(0.175,"BMD7-in",bmDuct),
  BM(bmprop, "BM7", bmDuct),
  DT(0.175,"BMD7-out", bmDuct),
  DT(0.125,"MRD14-in", MRD14),
  DT(0.2,"BMPi2", MRD14),
  DT(0.07, "MRD14-out", MRD14),
  DT(0.13,"MRD15-in", MRD15),
  QD(qdk,qlength,"QD4", MRD15),
  DT(0.3-0.05,"MRD15-out", MRD15),
  DT(0.1375,"DBPM6-in", bpmDuct), 
  DT(0,"STH6", bpmDuct),
  DT(0,"BPM6", bpmDuct),
  DT(0.1375,"DBPM6-out", bpmDuct),
  DT(0.175,"BMD8-in", bmDuct),
  BM(bmprop, "BM8", bmDuct),
  DT(0.175,"BMD8-out", bmDuct),
  DT(0.35,"FC4", [152.4e-3/2]),
  DT(0.875,"L31_1", [61])
  };
 
endfunction