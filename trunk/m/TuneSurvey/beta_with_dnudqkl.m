## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} beta_with_dnudqkl(@var{dnu}m @var)
##
## @end deftypefn

##== History
## not implemented.

function retval = beta_with_dnudqkl(varargin)
    beta_mat = [qf_beta.h, -qd_beta.h;
              -qf_beta.v, qd_beta.v];
endfunction

%!test
%! beta_with_dnudqkl(x)
