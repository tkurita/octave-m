## usage : 
##

##== Histtory
## 2008-11-28
## * support new format which BPM arraaned along with real machine.

function cod_at_BPM = cod_hold_data(filename, FBorFT)
  csv_data = csvread(filename);
  switch (FBorFT)
    case ("FT")
      id = csv_data(2, 2:end);
      a_row = csv_data(3,2:end);
    case ("FB")
      id = csv_data(4, 2:end);
      a_row = csv_data(5,2:end);
  endswitch
  
  for n = 1:length(id)
    cod_at_BPM.(sprintf("BPM%d", id(n))) = a_row(n);
  endfor
  
endfunction