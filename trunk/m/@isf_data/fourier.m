## -*- texinfo -*-
## @deftypefn {Function File} {@var{fourier_obj} =} fourier(@var{isf_data}, ["range", [@var{t1}, @var{t2}])
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
## 2014-12-11
## * first implementaion

function retval = fourier(isf, varargin)
  opts = get_properties(varargin, {"range"}, {[]});
  rng = opts.range;
  t = subsref(isf, struct("type", ".", "subs", "t"));
  v = isf.v;
  if !isempty(rng)
    ind = (t > rng(1)) & (t < rng(2));
    t = t(ind);
    v = v(ind);
  endif
  retval = fourier(v, subsref(isf, struct("type", ".", "subs", "ts")));
endfunction

%!test
%! func_name(x)
