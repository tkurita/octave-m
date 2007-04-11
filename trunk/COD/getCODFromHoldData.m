function codAtBPM = getCODFromHoldData(fileName,FBorFT)
  csvData = csvread(fileName);
  switch (FBorFT)
	case ("FT")
	  targetRow = csvData(3,:);
	case ("FB")
	  targetRow = csvData(5,:);
  endswitch

  codAtBPM.BPM1 = targetRow(2);
  codAtBPM.BPM2 = targetRow(3);
  codAtBPM.BPM3 = targetRow(4);
  codAtBPM.BPM4 = targetRow(5);
  codAtBPM.BPM5 = targetRow(6);
  codAtBPM.BPM6 = targetRow(7);
  codAtBPM.BPM7 = targetRow(8);

endfunction