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
## 2015-04-09
## * added "window" (window function) option.
## 2014-12-15
## * added "samplerange" option
## 2014-12-11
## * first implementaion

function retval = fourier(isf, varargin)
  opts = get_properties(varargin, {"range", "samplerange", "window"}, {[], [], []});
  v = isf.v;
  if !isempty(opts.range)
    rng = opts.range;
    t = subsref(isf, struct("type", ".", "subs", "t"));
    ind = (t > rng(1)) & (t < rng(2));
    v = v(ind);
  elseif !isempty(opts.samplerange)
    rng = opts.samplerange;
    v = v(rng(1):rng(2));
  endif
  retval = fourier(v, subsref(isf, struct("type", ".", "subs", "ts")), "window", opts.window);
endfunction

%!test
%! func_name(x)
