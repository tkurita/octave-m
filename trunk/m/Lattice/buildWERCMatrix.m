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
## 2013-10-29
## * call print_usage if no arguments are given.
## 2007-10-18
## * accept a structure as an argument

function all_elements = buildWERCMatrix(varargin)
  if ! nargin
    print_usage();
  endif
  
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
  bmDuct1 = [81e-3, -63e-3, 23e-3, -23e-3];
  bmDuct2 = [66e-3, -61e-3, 23e-3, -23e-3];
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
  #MRD9 = [103e-3, -76e-3, 14e-3, -14e-3];
  MRD9 = [103e-3, -76e-3, qfDuct(2), -qfDuct(2)]; # 改造したので縦はもっと広い
  MRD10 = [92e-3/2, 1e-3*(60.5-6)/2];
  MRD11 = 1e-3*(139.8-2*3.4)/2;
  MRD12_1 = 1e-3*(139.8-2*3.4)/2;
  MRD12_2 = qfDuct;
  MRD13 = MRD5;
  MRD14 = MRD4; #絶縁ダクト
  MRD15 = MRD3;
  ESD_in = [(58e-3)-(0.3e-3), -197.2e-3/2, 197.2e-3/2, -197.2e-3/2];
  ESD_middle = [61.5e-3, -197.2e-3/2, 197.2e-3/2, -197.2e-3/2];
  ESD_out = [71e-3, -197.2e-3/2, 197.2e-3/2, -197.2e-3/2];
  FCTDuct = 133e-3/2;
  RFK_Duct = 200e-3/2;
  SM_Duct = [135.1e-3/2, 46e-3/2];
  RFK_Electrode = [140e-3/2, 38e-3/2];
  RFC_Duct = [146e-3/2];
  all_elements = {
  DT(0.2250,"ESI", [61.2e-3, -77e-3, 77e-3, -77e-3]),
  DT(0.1750, "MRD1IN", MRD1),
  QF(qfk,qlength,"QF1", MRD1),
  DT(0.15, "MRD1OUT", MRD1),
  DT(0.1375,"DBPM1IN", bpmDuct),
  DT(0,"STH1", bpmDuct),
  DT(0,"BPM1", bpmDuct),
  DT(0.1375,"DBPM1OUT",bpmDuct),
  DT(0.230,"DPR1IN", [176e-3/2]),
  DT(0,"PR1", [176e-3/2]),
  DT(0.2, "DPR1OUT",[176e-3/2]);  
  DT(0.445,"MRD2IN", MRD2),
  DT(0.20,"SX1", MRD2),
  DT(0.125, "MRD2OUT", MRD2),
  DT(0.175, "BMD1IN", bmDuct1),
  BM(bmprop, "BM1", bmDuct1),
  DT(0.175, "BMD1OUT", bmDuct1),
  DT(0.1675,"FCT", FCTDuct),
  DT(0.2125,"DFCTOUT", FCTDuct),
  DT(0.1450,"MRD3IN", MRD3),
  QD(qdk,qlength,"QD1", MRD3),
  DT(0.13, "MRD3OUT", MRD3),
  DT(0.07, "MRD4IN", MRD4),
  DT(0.2, "BMPi1", MRD4),
  DT(0.125, "MRD4OUT", MRD4),
  DT(0.175, "BMD2IN", bmDuct2),
  BM(bmprop, "BM2", bmDuct2),
  DT(0.175, "BMD2OUT", bmDuct2),
  DT(0.35, "MRD5", MRD5),
  DT(0.1375, "DBPM2IN", bpmDuct),
  DT(0, "STH2", bpmDuct),
  DT(0, "BPM2", bpmDuct),
  DT(0.1375, "DBPM2OUT", bpmDuct),
  DT(0.16, "RFKD", RFK_Duct),
  DT(0.2, "RFKH", RFK_Electrode),
  DT(0.16, "RFKV", RFK_Electrode),
  DT(0.3, "CT", (133e-3)/2),
  DT(0.18, "MRD6IN", MRD6),
  QF(qfk,qlength,"QF2", MRD6),
  DT(0.245,"MRD6OUT", MRD6),
  DT(0.22,"DSCRIN", 220e-3/2),
  #DT(0.06,"SCRH", [68e-3, -68e-3, 203e-3/2, -203e-3/2]),
  DT(0.06,"SCRH", [58e-3, -48e-3, 203e-3/2, -203e-3/2]),
  DT(0.025, "DSCR", 203e-3/2),
  DT(0.005, "SCRV", [152e-3/2, -152e-3/2, 17.5e-3, -17.5e-3]),
  DT(0.140, "DSCROUT", 152e-3/2),
  DT(0.185,"MRD7IN", MRD7),
  DT(0.2,"STV1", MRD7),
  DT(0.2,"MRD7M", MRD7),
  DT(0.2,"SX2", MRD7),
  DT(0.145,"MRD7OUT", MRD7),
  DT(0.175, "BMD3IN", bmDuct2),
  BM(bmprop, "BM3", bmDuct2),
  DT(0.175, "BMD3OUT", bmDuct2),
  DT(0.125,"MRD8IN", MRD8),
  DT(0.2,"BMPe1", MRD8),
  DT(0.2,"MRD8M", MRD8),
  QD(qdk,qlength,"QD2", MRD8),
  DT(0.25,"MRD8OUT", MRD8),
  DT(0.1375,"DBPM3IN", bpmDuct),
  DT(0,"STH3", bpmDuct),
  DT(0,"BPM3", bpmDuct),
  DT(0.1375,"DBPM3OUT", bpmDuct),
  DT(0.175, "BMD4IN", bmDuct2),
  BM(bmprop, "BM4", bmDuct2),
  DT(0.175, "BMD4OUT", bmDuct2),
  DT(0.17, "ESDChamberIN", 197.2e-3/2),
  DT(0.025, "ESDIN", ESD_in),
  DT(0.45, "ESD1", ESD_middle),
  DT(0.45, "ESD2", ESD_middle),
  DT(0.0266, "ESDOUT", ESD_out),
  DT(0.3584, "ESDChamberOUT", 197.2e-3/2),
  DT(0.145, "MRD9IN", MRD9),
  QF(qfk, qlength, "QF3", MRD9),
  DT(0.22, "MRD9OUT", MRD9),
  DT(0.63, "SMIN", SM_Duct),
  DT(0.5, "SM", SM_Duct),
  DT(0.1375, "DBPM4IN", bpmDuct),
  DT(0, "STH4", bpmDuct),
  DT(0, "BPM4", bpmDuct),
  DT(0.1375, "DBPM4OUT", bpmDuct),
  DT(0.175, "BMD5IN", bmDuct2),
  BM(bmprop, "BM5", bmDuct2),
  DT(0.175,"BMD5OUT", bmDuct2),
  DT(0.1975,"DPR2IN", [143.2e-3/2]),
  DT(0, "PR2", [143.2e-3/2]),
  DT(0.2025, "DPR2OUT", [143.2e-3/2]),
  DT(0.125, "MRD10IN", MRD10),
  QD(qdk,qlength,"QD3", MRD10),
  DT(0.2,"MRD10M", MRD10),
  DT(0.2,"BMPe2", MRD10),
  DT(0.125,"MRD10OUT", MRD10),
  DT(0.175,"BMD6IN", bmDuct2),
  BM(bmprop, "BM6", bmDuct2),
  DT(0.175, "BMD6OUT", bmDuct2),
  DT(0.1375,"DBPM7IN", bpmDuct),
  DT(0,"BPM7", bpmDuct),
  DT(0.1375,"DBPM7OUT",bpmDuct),
  DT(0.2,"DPRERFC", RFC_Duct),
  DT(0.05,"DRFCIN", RFC_Duct),
  DT(0.6,"RFC", RFC_Duct),
  DT(0.05, "DRFCOUT", RFC_Duct),
  DT(0.315,"MRD12IN1", MRD12_1),
  DT(0.135, "MRD12IN2", MRD12_2),
  QF(qfk,qlength,"QF4", MRD12_2), 
  DT(0.15, "MRD12OUT", MRD12_2),
  DT(0.1375,"DBPM5IN", bpmDuct),
  DT(0,"BPM5", bpmDuct),
  DT(0,"STH5", bpmDuct),
  DT(0.1375,"DBPM5OUT",bpmDuct),
  DT(0.13, "MRD13IN", MRD13),
  DT(0.2, "STV2", MRD13),
  DT(0.525, "MRD13M", MRD13),
  DT(0.2,"SX3", MRD13),
  DT(0.145,"MRD13OUT", MRD13),
  DT(0.175,"BMD7IN",bmDuct2),
  BM(bmprop, "BM7", bmDuct2),
  DT(0.175,"BMD7OUT", bmDuct2),
  DT(0.125,"MRD14IN", MRD14),
  DT(0.2,"BMPi2", MRD14),
  DT(0.07, "MRD14OUT", MRD14),
  DT(0.13,"MRD15IN", MRD15),
  QD(qdk,qlength,"QD4", MRD15),
  DT(0.3-0.05,"MRD15OUT", MRD15),
  DT(0.1375,"DBPM6IN", bpmDuct), 
  DT(0,"STH6", bpmDuct),
  DT(0,"BPM6", bpmDuct),
  DT(0.1375,"DBPM6OUT", bpmDuct),
  DT(0.175,"BMD8IN", bmDuct1),
  BM(bmprop, "BM8", bmDuct1),
  DT(0.175,"BMD8OUT", bmDuct1),
  DT(0.35,"FC4", [152.4e-3/2]),
  DT(0.33, "ESIChamberIN", [165e-3/2]),
  DT(0.545, "ESIChamber", [61e-3])};
endfunction