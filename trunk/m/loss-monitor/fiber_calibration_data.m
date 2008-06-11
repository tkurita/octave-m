1;

##== section 1 outside
sec1_outside_ctable = ...
{{"QF1", "exit", 126},
{"BMD1IN", "entrance", 495}, 
{"MRD3IN", "entrance", 1101},
{"BMD2IN", "entrance", 1295}, 
{"BMD2OUT", "exit", 1731},
{"QF2", "entrance", 2085}};

##== section 1 inside
sec1_inside_ctable = ...
{{"QF1", "exit", 128},
{"BMD1IN", "entrance", 477}, 
{"MRD3IN", "entrance", 1095},
{"BMD2IN", "entrance", 1298}, 
{"BMD2OUT", "exit", 1709},
{"QF2", "entrance", 2051}};

##== section 2 outside
sec2_outside_ctable = ...
{{"QF2", "exit", 276},
{"BMD3IN", "entrance", 633},
{"BMD3OUT", "exit", 1055},
{"QD2", "entrance", 1174},
{"BMD4IN", "entrance", 1341},
{"BMD4OUT", "exit", 1771 },
{"QF3", "exit", 2207}};

##== section 2 inside
sec2_inside_ctable =...
{{"QF3", "exit", 2140},
{"BMD4OUT", "exit", 1712},
{"BMD4IN", "entrance", 1316},
{"QD2", "entrance", 1144},
{"BMD3OUT", "exit", 1055},
{"BMD3IN", "entrance", 653},
{"QF2", "exit", 283}};

##== section 3 outside
sec3_outside_ctable =...
{{"BMD5IN", "entrance",453},
{"BMD5OUT", "exit", 907},
{"QD3", "entrance", 984}, 
{"BMD6IN", "entrance", 1195},
{"BMD6OUT", "exit", 1613}, 
{"DRFCIN", "entrance", 1720},
{"QF4", "entrance", 2068},
{"STV2", "entrance", 2231}};

##== section 3 inside
sec3_inside_ctable =...
{{"BMD5IN", "entrance" ,378},
{"BMD5OUT", "exit" ,769},
{"QD3", "entrance",863}, 
{"BMD6IN", "entrance",1049},
{"BMD6OUT", "exit",1461}, 
{"DRFCIN", "entrance",1566},
{"QF4", "entrance", 1897},
{"STV2", "entrance",2068}};


##== section 4 outside
sec4_outside_ctable =...
{{"STV2", "exit", 268},
{"BMD7IN", "entrance", 418},
{"BMD7OUT", "exit", 840},
{"QD4", "exit", 1018},
{"BMD8IN", "entrance", 1118},
{"BMD8OUT", "exit", 1551},
{"QF1", "exit", 2020},
{"DPR1OUT", "exit", 2208}};

##== section 4 inside
sec4_inside_ctable =...
{{"STV2", "exit", 224},
{"BMD7IN", "entrance", 406}, 
{"BMD7OUT", "exit", 804},
{"QD4", "exit", 984},
{"BMD8IN", "entrance", 1101}, 
{"BMD8OUT", "exit", 1489},
{"QF1", "exit", 1951},
{"DPR1OUT", "exit", 2137}};
