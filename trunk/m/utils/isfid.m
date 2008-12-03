## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} isfid(@var{arg})
##
## Return true, if @var{fid} is opend valid stream number.
##
## @end deftypefn

##== History
## 2008-12-03
## * First Implementation

function retval = isfid(fid)
  try
    msg = ferror(fid);
    retval = (length(msg) == 0);
  catch
    retval = false;
  end_try_catch
endfunction

%!test
%! isfid(x)
