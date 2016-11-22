## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} reverse_interp(@var{yi})
## Obtain reverse interpolated value for @var{yi}.
##
## @end deftypefn

function retval = reverse_interp(ci, yi)
  if ! nargin
    print_usage();
  endif
  if !isfield(ci.opts, "rx")
    ci.opts.rx = linspace(ci.x(1), ci.x(end), 1000);
    ci.opts.ry = ppval(ci.pp, ci.opts.rx);
  endif
  retval = interp1(ci.opts.ry, ci.opts.rx, yi);
endfunction

%!test
%! func_name(x)
