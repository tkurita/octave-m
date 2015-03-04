## usage : sGramRec = loadSgram(file)
##
## = Result
## * sGramRec
##      .Hz
##      .MHz
##      .msec
##      .dBm

##== History
## 2009-06-01
## * deprecated. Use load_spectrum_csv
## * support ver. 3

function sGramRec = loadSgram(file)
  warning("loadSgram is obsolete. Use load_spectrum_csv")
  mat = csvread(file);
  Hz = mat(1, 2:end);
  MHz = Hz/1e6;
  msec = vec(mat(2:end,1))*1e3;
  dBm = mat(2:end,2:end);
  sGramRec = tars(Hz, MHz, msec, dBm);
endfunction
