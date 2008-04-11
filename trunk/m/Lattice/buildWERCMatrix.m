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
  MRD8 = [72e-3/2, 1e-3*(60.5-3)/2];
  MRD9 = [103e-3, -76e-3, 14e-3, -14e-3];
  MRD10 = [120e-3/2, 1e-3*(55-6)/2];
  MRD11 = 1e-3*(139.8-2*3.4)/2;
  MRD12 = qfDuct;
  MRD13 = MRD5;
  MRD14 = MRD4; #絶縁ダクト
  MRD15 = MRD3;
  FCTDuct = 133e-3/2;
  RFK_Duct = 200e-3/2;
  RFK_Electrode = [140e-3/2, 38e-3/2];
  all_elements = {
  DT(0.4,"ESI", [61.2e-3, -77e-3, 77e-3, -77e-3]),
  QF(qfk,qlength,"QF1", MRD1),
  DT(0.3,"L1", MRD1),
  DT(0.05,"STH1", bpmDuct),
  DT(0.05,"BPM1", bpmDuct),
  DT(0.30,"L2", [176e-3/2]),
  DT(0.05,"PR1", [176e-3/2]),
  DT(0.55,"L0A", MRD2),
  DT(0.20,"SX1", MRD2),
  DT(0.3,"L3", MRD2),
  BM(bmprop, "BM1", bmDuct),
  DT(0.2,"L4", bmDuct),
  DT(0.05,"FCT", FCTDuct),
  DT(0.45,"L41", MRD3),
  QD(qdk,qlength,"QD1", MRD3),
  DT(0.2, "L5", MRD3),
  DT(0.2, "BMPi1", MRD4),
  DT(0.3, "L6", bmDuct),
  BM(bmprop, "BM2", bmDuct),
  DT(0.175, "L7", bmDuct),
  DT(0.35, "MRD5", MRD5),
  DT(0.05, "STH2", bpmDuct),
  DT(0.05, "BPM2", bpmDuct),
  DT(0.175, "L8", bpmDuct),
  DT(0.16, "RFK_Duct", RFK_Duct),
  DT(0.2, "RFK_H", RFK_Electrode),
  DT(0.16, "RFK_V", RFK_Electrode),
  DT(0.48, "L9", MRD6),
  QF(qfk,qlength,"QF2", MRD6),
  DT(0.65,"L10", MRD6),
  DT(0.05,"SCR", [68e-3, -68e-3, 17.5e-3, -17.5e-3]),
  #DT(0.6,"L11"),
  DT(0.15,"L11_1", MRD7),
  DT(0.3,"STV1", MRD7),
  DT(0.15,"L11_2", MRD7),
  DT(0.2,"SX2", MRD7),
  DT(0.3,"L12", MRD7),
  BM(bmprop, "BM3", bmDuct),
  DT(0.3,"L1A", MRD8),
  DT(0.2,"BMPe1", MRD8),
  DT(0.2,"L13", MRD8),
  QD(qdk,qlength,"QD2", MRD8),
  DT(0.3,"L14", MRD8),
  DT(0.05,"STH3", bpmDuct),
  DT(0.05,"BPM3", bpmDuct),
  DT(0.3,"L15", bpmDuct),
  BM(bmprop, "BM4", bmDuct),
  DT(0.175, "L16_1", bmDuct),
  DT(0.195, "L16_2", 197.2e-3/2),
  #DT(0.37,"L16"),
  DT(0.9, "ESD", [(58e-3)-(0.3e-3), -197.2e-3/2, 197.2e-3/2, -197.2e-3/2]),
  DT(0.53, "L17", MRD9),
  QF(qfk, qlength, "QF3", MRD9),
  #DT(1.4,"L18"),
  DT(0.9, "L18_1", MRD9),
  DT(0.5, "SM", MRD9),
  DT(0.05, "STH4", bpmDuct),
  DT(0.05, "BPM4", bpmDuct),
  #DT(0.3, "L19"),
  DT(0.125, "L19_1", bpmDuct),
  DT(0.175, "L19_2", bmDuct),
  BM(bmprop, "BM5", bmDuct),
  DT(0.175,"L20_1", bmDuct),
  DT(0.225,"L20_2", [143.2e-3/2]); 
  #DT(0.4,"L20"),
  DT(0.05,"PR2", [143.2e-3/2]),
  DT(0.25, "L2A", MRD10),
  QD(qdk,qlength,"QD3", MRD10),
  DT(0.2,"L21", MRD10),
  DT(0.2,"BMPe2", MRD10),
  #DT(0.3,"L22"),
  DT(0.125,"L22_1", MRD10),
  DT(0.175,"L22_2", bmDuct),
  BM(bmprop, "BM6", bmDuct),
  DT(0.175, "L23_1", bmDuct),
  DT(0.275, "L23_2", bpmDuct),
  #DT(0.45,"L23"),
  DT(0.05,"BPM7", bpmDuct),
  DT(0.2,"L24", bpmDuct),
  DT(0.6,"RFC", [146e-3/2]),
  DT(0.5,"L2B", MRD12),
  QF(qfk,qlength,"QF4", MRD12),
  DT(0.3,"L25", bpmDuct),
  DT(0.05,"STH5", bpmDuct),
  DT(0.05,"BPM5", bpmDuct),
  DT(0.9,"L2C", MRD13),
  DT(0.2,"SX3", MRD13),
  #DT(0.3,"L26"),
  DT(0.125,"L26_1", MRD13),
  DT(0.175,"L26_2",bmDuct),
  BM(bmprop, "BM7", bmDuct),
  DT(0.175,"L27_1", bmDuct),
  DT(0.125,"L27_2", MRD14),
  #DT(0.3,"L27"),
  DT(0.2,"BMPi2", MRD14),
  DT(0.2,"L28", MRD15),
  QD(qdk,qlength,"QD4", MRD15),
  DT(0.3,"L2D", MRD15),
  DT(0.05,"STH6", bpmDuct),
  DT(0.05,"BPM6", bpmDuct),
  #DT(0.3,"L29"),
  DT(0.125,"L29_1", bpmDuct),
  DT(0.175,"L29_2", bmDuct),
  BM(bmprop, "BM8", bmDuct),
  DT(0.175,"L30_1", bmDuct),
  #DT(0.35,"L30", [152.4e-3/2]),
  DT(0.35,"FC4", [152.4e-3/2]),
  #DT(0.05,"FC4", [152.4e-3/2]),
  DT(0.875,"L31_1", [152.4e-3/2])
  #DT(1,"L31", [152.4e-3/2])
  };
 
endfunction