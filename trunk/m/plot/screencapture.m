## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} screencapture(@var{filename})
## run screencaputre command with window selection mode.
## @end deftypefn

##== History
## 2014-11-13
## * first implementation

function retval = screencapture(filename)
  if ! nargin
    print_usage();
  endif
  system(["screencapture -w -o ", filename]);
endfunction

%!test
%! screencapture(x)
