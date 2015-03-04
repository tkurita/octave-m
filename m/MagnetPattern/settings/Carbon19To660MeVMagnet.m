## BM Pattern of C 19MeV -> 660MeV C001
1; # script file

function retval = BMPattern
  ## [msec], [(T/m)*m]
  pattern_cells = ...
      {
      0,      0.2876, "linear";
      35,     0.2876, "spline";
      60,     0.2974, "";
      85,     0.3466, "linear";
      643.4 , 1.6642, "spline";
      668.4 , 1.7134, "";
      693.4 , 1.7232, "linear";
      1131.6, 1.7232, "spline";
      1156.6, 1.7134, "";
      1181.6, 1.6642, "linear";
      1740,   0.3466, "spline";
      1765,   0.2974, "";
      1790,   0.2876, "linear";
      2000,   0.2876, 0};
  retval = build_pattern(pattern_cells);
endfunction

function retval = QFPattern
  pattern_cells = {...
    0,0.0922  "linear";
    35,0.0922  "spline";
    60,0.0954  "";
    85,0.1111  "linear";
    643.4,0.5324 , "spline";
    668.4,0.5482 , "";
    693.4,0.5513 , "spline";
    705.9 ,0.5505 , "";
    730.9 ,0.5420 , "";
    743.4 ,0.5411 , "linear";
    1081.6 ,0.5411, "spline";
    1094.1 ,0.5420 , "";
    1119.1 ,0.5505 , "";
    1131.61,0.5513 , "spline";
    1156.61,0.5482 , "";
    1181.61,0.5324 , "linear";
    1740,0.1111 , "spline";
    1765,0.0954 , "";
    1790,0.0922 , "linear";
    2000,0.0922 , 0};
  retval = build_pattern(pattern_cells);
endfunction

function retval = QDPattern
  pattern_cells = {...
    0,0.0986, "linear";
    41,0.0986, "spline";
    68,0.1019, "";
    95,0.1188, "linear";
    643.4,0.5695, "spline";
    668.4,0.5863, "";
    693.4,0.5897, "linear";
    1131.61,0.5897, "spline";
    1156.61,0.5863, "";
    1181.61,0.5695, "linear";
    1740,0.1188, "spline";
    1765,0.1019, "";
    1790,0.0986, "linear";
    2000,0.0986, 0};

  retval = build_pattern(pattern_cells);
endfunction

%!test
%! Carbon19To660MeVMagnet;
%! plot_bpattern(BMPattern, QFPattern, QDPattern, "B")

