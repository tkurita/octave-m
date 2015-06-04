## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} save_csv(@var{rfv}, @var{output})
## description
## @strong{Inputs}
## @table @var
## @item rfv
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

function retval = save_csv(rfv, outfile, varargout)
  if ! nargin
    print_usage();
  endif
  fs = 10e3; # サンプリング周波数 [Hz] 三光社 F.G.
  v_pattern = vs_time(rfv, "frequency", fs);
  retval = bit_with_control_v(control_v_for_rf_amplitude(v_pattern));
  csvwrite(outfile, retval(:))
endfunction

%!test
%! func_name(x)
