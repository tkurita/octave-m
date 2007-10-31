## usage : sGramRec = loadSgram(file)
##
## = Result
## * sGramRec
##      .Hz
##      .MHz
##      .msec
##      .dBm

function sGramRec = loadSgram(file)
  mat = csvread(file);
  Hz = mat(1, 2:end);
  MHz = Hz/1e6;
  msec = vec(mat(2:end,1))*1e3;
  dBm = mat(2:end,2:end);
  sGramRec = tar(Hz, MHz, msec, dBm);
endfunction
