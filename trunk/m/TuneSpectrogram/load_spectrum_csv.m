## -*- texinfo -*-
## @deftypefn {Function File} {@var{specdata} =} load_spectrum_csv(@var{file})
##
## Parse a spectrum csv file (output from iqt2fft) and return @var{specdata} structure.
##
## @var{specdata} has following fields.
##
## @table @code
## @item Hz
## @item MHz
## @item msec
## @item dBm
## @end table
## @end deftypefn

##== History
## 2009-06-01
## * renamed from loadSgram
## * support ver. 3


function specdata = load_spectrum_csv(file)
  mat = csvread(file);
  Hz = mat(1, 2:end);
  MHz = Hz/1e6;
  msec = vec(mat(2:end,1))*1e3;
  dBm = mat(2:end,2:end);
  specdata = tars(Hz, MHz, msec, dBm);
endfunction
