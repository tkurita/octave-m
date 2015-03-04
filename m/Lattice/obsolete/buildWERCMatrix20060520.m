## usage: allElements = buildWERCMatrix(qfk,qdk)
## WERC シンクロトロンの全要素の matrix の配列を返す。
## qfk : Q lens の長さをかけると、QF の収束力 [1/(m*m)]
## qfd : Q lens の長さをかけると、QD の収束力 [1/(m*m)]
## 要素の field
## .len : 長さ
## .name : 名前
## .mat.h : 横方向の matrix 3×3
## .twmat.h : 横方向の twiss parameter を計算する matrix
## .mat.v : 縦方向の matrix 3×3
## .twmat.v : 縦方向の twiss parameter を計算する matrix

function allElements = buildWERCMatrix(qfk,qdk)
  bmangle = (45/360)*2*pi;
  bmradius = 1.91;
  #edgeangle = 0.75*2*pi/360;
  edgeangle = 1.5*pi/180;
  qlength = 0.15; #length of q magnet [m]
  
  ## Duct サイズ
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
  
  ESI = DT(0.4,"ESI", [61.2e-3, -77e-3, 77e-3, -77e-3]);
  QF1 = QF(qfk,qlength,"QF1", MRD1);
  L1 = DT(0.3,"L1", MRD1);
  SH1 = DT(0.05,"SH1", bpmDuct);
  BP1 = DT(0.05,"BP1", bpmDuct);
  L2 = DT(0.30,"L2", [176/2]);
  PR1 = DT(0.05,"PR1", [176/2]);
  L0A = DT(0.55,"L0A", MRD2);
  SX1 = DT(0.20,"SX1", MRD2);
  L3 = DT(0.3,"L3", MRD2);
  BM1 = BMH(bmradius,bmangle,edgeangle,"BM1", bmDuct);
  L4 = DT(0.2,"L4", bmDuct);
  FCT = DT(0.05,"FCT", FCTDuct);
  L41 = DT(0.45,"L41", MRD3);
  QD1 = QD(qdk,qlength,"QD1", MRD3);
  L5 = DT(0.2, "L5", MRD3);
  BMPi1 = DT(0.2, "BMPi1", MRD4);
  L6 = DT(0.3, "L6", bmDuct);
  BM2 = BMH(bmradius,bmangle,edgeangle,"BM2", bmDuct);
  L7 = DT(0.6,"L7", MRD5);
  SH2 = DT(0.05,"SH2", bpmDuct);
  BP2 = DT(0.05,"BP2", bpmDuct);
  L8 = DT(0.3,"L8", bpmDuct);
  RFK = DT(0.3,"RFK", [140/2, 38/2]);
  L9 = DT(0.5,"L9", MRD6);
  QF2 = QF(qfk,qlength,"QF2", MRD6);
  L10 = DT(0.65,"L10", MRD6);
  SCR = DT(0.05,"SCR", [68e-3, -68e-3, 17.5e-3, -17.5e-3]);
  # L11 = DT(0.6,"L11");
  L11_1 = DT(0.15,"L11_1", MRD7);
  STV1 = DT(0.3,"STV1", MRD7);
  L11_2 = DT(0.15,"L11_2", MRD7);
  SX2 = DT(0.2,"SX2", MRD7);
  L12 = DT(0.3,"L12", MRD7);
  BM3 = BMH(bmradius,bmangle,edgeangle,"BM3", bmDuct);
  L1A = DT(0.3,"L1A", MRD8);
  BMPe1 = DT(0.2,"BMPe1", MRD8);
  L13 = DT(0.2,"L13", MRD8);
  QD2 = QD(qdk,qlength,"QD2", MRD8);
  L14 = DT(0.3,"L14", MRD8);
  SH3 = DT(0.05,"SH3", bpmDuct);
  BP3 = DT(0.05,"BP3", bpmDuct);
  L15 = DT(0.3,"L15", bpmDuct);
  BM4 = BMH(bmradius,bmangle,edgeangle,"BM4", bmDuct);
  L16_1 = DT(0.175, "L16_1", bmDuct);
  L16_2 = DT(0.195, "L16_2", 197.2e-3/2);
  #L16 = DT(0.37,"L16");
  ESD = DT(0.9, "ESD", [58e-3, -197.2e-3/2, 197.2e-3/2, -197.2e-3/2]);
  L17 = DT(0.53, "L17", MRD9);
  QF3 = QF(qfk, qlength, "QF3", MRD9);
  # L18 = DT(1.4,"L18");
  L18_1 = DT(0.9, "L18_1", MRD9);
  SM = DT(0.5, "SM", MRD9);
  SH4 = DT(0.05, "SH4", bpmDuct);
  BP4 = DT(0.05, "BP4", bpmDuct);
  #L19 = DT(0.3, "L19");
  L19_1 = DT(0.125, "L19_1", bpmDuct);
  L19_2 = DT(0.175, "L19_2", bmDuct);
  BM5 = BMH(bmradius,bmangle,edgeangle,"BM5", bmDuct);
  L20_1 = DT(0.175,"L20_1", bmDuct);
  L20_2 = DT(0.225,"L20_2", [143.2/2]); 
  #L20 = DT(0.4,"L20");
  PR2 = DT(0.05,"PR2", [143.2/2]);
  L2A = DT(0.25, "L2A", MRD10);
  QD3 = QD(qdk,qlength,"QD3", MRD10);
  L21 = DT(0.2,"L21", MRD10);
  BMPe2 = DT(0.2,"BMPe2", MRD10);
  #L22 = DT(0.3,"L22");
  L22_1 = DT(0.125,"L22_1", MRD10);
  L22_2 = DT(0.175,"L22_2", bmDuct);
  BM6 = BMH(bmradius,bmangle,edgeangle,"BM6", bmDuct);
  L23_1 = DT(0.175, "L23_1", bmDuct);
  L23_2 = DT(0.275, "L23_2", bpmDuct);
  #L23 = DT(0.45,"L23");
  BP7 = DT(0.05,"BP7", bpmDuct);
  L24 = DT(0.2,"L24", bpmDuct);
  RFC = DT(0.6,"RFC", [146/2]);
  L2B = DT(0.5,"L2B", MRD12);
  QF4 = QF(qfk,qlength,"QF4", MRD12);
  L25 = DT(0.3,"L25", bpmDuct);
  SH5 = DT(0.05,"SH5", bpmDuct);
  BP5 = DT(0.05,"BP5", bpmDuct);
  L2C = DT(0.9,"L2C", MRD13);
  SX3 = DT(0.2,"SX3", MRD13);
  #L26 = DT(0.3,"L26");
  L26_1 = DT(0.125,"L26_1", MRD13);
  L26_2 = DT(0.175,"L26_2",bmDuct);
  BM7 = BMH(bmradius,bmangle,edgeangle,"BM7", bmDuct);
  L27_1 = DT(0.175,"L27_1", bmDuct);
  L27_2 = DT(0.125,"L27_2", MRD14);
  #L27 = DT(0.3,"L27");
  BMPi2 = DT(0.2,"BMPi2", MRD14);
  L28 = DT(0.2,"L28", MRD15);
  QD4 = QD(qdk,qlength,"QD4", MRD15);
  L2D = DT(0.3,"L2D", MRD15);
  SH6 = DT(0.05,"SH6", bpmDuct);
  BP6 = DT(0.05,"BP6", bpmDuct);
  #L29 = DT(0.3,"L29");
  L29_1 = DT(0.125,"L29_1", bpmDuct);
  L29_2 = DT(0.175,"L29_2", bmDuct);
  BM8 = BMH(bmradius,bmangle,edgeangle,"BM8", bmDuct);
  L30_1 = DT(0.175,"L30_1", bmDuct);
  #L30 = DT(0.35,"L30", [152.4e-3/2]);
  FC4 = DT(0.35,"FC4", [152.4e-3/2]);
  #FC4 = DT(0.05,"FC4", [152.4e-3/2]);
  L31_1 = DT(0.875,"L31_1", [152.4e-3/2]);
  #L31 = DT(1,"L31", [152.4e-3/2]);
  
  allElements = {
  ESI,
  QF1,
  L1,
  SH1,
  BP1,
  L2,
  PR1,
  L0A,
  SX1,
  L3,
  BM1,
  L4,
  FCT,
  L41,
  QD1,
  L5,
  BMPi1,
  L6,
  BM2,
  L7,
  SH2,
  BP2,
  L8,
  RFK,
  L9,
  QF2,
  L10,
  SCR,
  #L11,
  L11_1,
  STV1,
  L11_2,
  SX2,
  L12,
  BM3,
  L1A,
  BMPe1,
  L13,
  QD2,
  L14,
  SH3,
  BP3,
  L15,
  BM4,
  L16_1,
  L16_2, 
  #L16,
  ESD,
  L17,
  QF3,
  #L18,
  L18_1,
  SM,
  SH4,
  BP4,
  #L19,
  L19_1,
  L19_2,
  BM5,
  L20_1,
  L20_2,
  #L20,
  PR2,
  L2A,
  QD3,
  L21,
  BMPe2,
  #L22,
  L22_1,
  L22_2,
  BM6,
  #L23,
  L23_1,
  L23_2,
  BP7,
  L24,
  RFC,
  L2B,
  QF4,
  L25,
  SH5,
  BP5,
  L2C,
  SX3,
  #L26,
  L26_1,
  L26_2,
  BM7,
  L27_1,
  L27_2,
  #L27,
  BMPi2,
  L28,
  QD4,
  L2D,
  SH6,
  BP6,
  #L29,
  L29_1,
  L29_2,
  BM8,
  L30_1,
  FC4,
  L31_1};
endfunction