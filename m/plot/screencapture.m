## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} screencapture(@var{filename})
## run screencaputre command with window selection mode.
## @end deftypefn

##== History
## 2014-11-29
## * show the path extension.
## 2014-11-14
## * call remove_windowparts
## 2014-11-13
## * first implementation

function retval = screencapture(filename)
  if ! nargin
    print_usage();
  endif
  system(["screencapture -w -o ", filename]);
  system(["SetFile -a e ", filename]); # show the path extension.
  retval = remove_windowparts(filename);
endfunction

%!test
%! screencapture(x)
