## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} diff_hv(@var{s1}, @var{s2})
##
## @example
## @var{result}.h = @var{s1}.h - @var{s2}.h
## @var{result}.v = @var{s1}.v - @var{s2}.v
## @end example
## 
##
## @end deftypefn

##== History
##

function retval = diff_hv(s1, s2)
  retval.h = s1.h - s2.h;
  retval.v = s1.v - s2.v;
endfunction

%!test
%! diff_hv(x)
