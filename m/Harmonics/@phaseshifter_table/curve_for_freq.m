## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} curve_for_freq(@var{phaseshifter_table})
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

function retval = curve_for_freq(pst, f, v)
  if ! nargin
    print_usage();
  endif
  
  if nargin < 3
    v = pst.rad_v{1}(:,1);
  endif
  rad_interp = [];
  for n = 1:length(v)
    rad_vs_f = [];
    for m = 1:length(pst.freq)
      rad_at_v = interp1(pst.rad_v{m}(:,1), pst.rad_v{m}(:,2), v(n));
      rad_vs_f(m,:) = [pst.freq(m), rad_at_v];
    endfor
    rad_interp(n) = interp1(rad_vs_f(:,1), rad_vs_f(:,2), f);
  endfor
  retval = phaseshifter_curve(v, rad_interp(:));
endfunction

%!test
%! func_name(x)
