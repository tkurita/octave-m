## usage : 
function cod_at_BPM = cod_hold_data(filename, FBorFT)
  csv_data = csvread(filename);
  switch (FBorFT)
    case ("FT")
      a_row = csv_data(3,:);
    case ("FB")
      a_row = csv_data(5,:);
  endswitch
  
  cod_at_BPM.BPM1 = a_row(2);
  cod_at_BPM.BPM2 = a_row(3);
  cod_at_BPM.BPM3 = a_row(4);
  cod_at_BPM.BPM4 = a_row(5);
  cod_at_BPM.BPM5 = a_row(6);
  cod_at_BPM.BPM6 = a_row(7);
  cod_at_BPM.BPM7 = a_row(8);
  
endfunction