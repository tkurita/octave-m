## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} apply_fir1_xy(@var{n}, @var{fc}, @var{xy})
## make a fir filter using @var{n} and @var{fcn} and appy it to @var{v}.
## @strong{Inputs}
## @table @var
## @item n
## filter order
## @item fc
## cut off frequency in Hz
## @item xy
## values to apply filter. 
## @end table
##
## @end deftypefn

function varargout = apply_fir1_xy(n, fc, xy, varargin);
  v = xy(:,2);
  t = xy(:,1);
  ts = t(2) - t(1);
  fcn = 2*ts*fc; # normalized frequency
  [v, gd] = apply_fir1(n, fcn, v, varargin{:});
  if (!isna(gd))
    t = t(1:end-gd);
  endif
  xy = [t, v];
  
  if nargout > 1
    varargout = {xy, gd};
  else
    varargout = {xy};
  endif
endfunction

%!test
%! func_name(x)
