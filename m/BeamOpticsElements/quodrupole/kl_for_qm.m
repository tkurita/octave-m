## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} kl_for_qm(@var{qm})
##
## Obtain K*L of a quadropole magnet.
##
## @example
## @var{qm}.efflen * @var{qm}.k
## @end example
##
## @end deftypefn

##== History
## 2009-05-29
## * First implementation.

function retval = kl_for_qm(qm)
  if (!nargin)
    print_usage();
    return;
  endif
  
  if (isfield(qm, "efflen"))
    l = qm.efflen;
  else
    l = qm.len;
  endif
  
  retval = qm.k * l;
endfunction

%!test
%! kl_for_qm(x)
