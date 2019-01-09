## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} polyfit_xy(@var{xy}, @var{n})
## apply polyfit to @var{xy} matrix.
## @strong{Inputs}
## @table @var
## @item xy
## @item n
## order of polynominal expression.
## @end table
##
## @strong{Outputs}
## The output is a structure returned from polyfit adding 'p' field.
##
## @end deftypefn

function retval = polyfit_xy(xy_in, n, varargin)
  if ! nargin
    print_usage();
  endif
  opts = get_properties(varargin, {"xrange", NA});
  if (! isna(opts.xrange))
    xy_in = xy_in_xrange(xy_in, opts.xrange);
  endif
  [p, retval] = polyfit(xy_in(:,1), xy_in(:,2), n);
  retval.p = p;
  retval.xy = [xy_in(:,1), retval.yf];
endfunction

%!test
%! func_name(x)
