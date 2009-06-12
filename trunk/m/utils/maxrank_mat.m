## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} maxrank_mat(@var{arg})
##
## @end deftypefn

##== History
##

function X = maxrank_mat(x, varargin)
  if (length(varargin) > 0)
    opts = get_properties(varargin, 
                          {"crossing_origin", "maxorder"},
                          {true, 0});
  endif
  if opts.crossing_origin 
    min_exp_ind = 1;
  else
    min_exp_ind = 0;
  endif
  l = length(x);
  if (opts.maxorder > 0)
    n = opts.maxorder;
  else
    n = l;
  endif
  X = (x*ones(1, n)).^(ones(l, 1)*(min_exp_ind:n-(1-min_exp_ind)));
  r = rank(X);
  if (r < n)
    X = (x*ones(1, r)).^(ones(l, 1)*(min_exp_ind:r-(1-min_exp_ind)));
  endif
#  n
#  l
endfunction

%!test
%! func_name(x)
