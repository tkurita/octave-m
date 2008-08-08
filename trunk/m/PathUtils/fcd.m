## -*- texinfo -*-
## @deftypefn {Function File} {} fcd
##
## @end deftypefn

##== History
## 2008-06-18
## * firrst implementation

function fcd()
  [status, output] = system("fcd.sh");
  cd(output(1:end-1));
endfunction