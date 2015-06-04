## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} save_csv(@var{rfvp}, @var{outfile})
## Write into a csv file for the input of the Sankosha function generator.
## @strong{Inputs}
## @table @var
## @item rfvp
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## output data written in @var{outfile}
## @end table
##
## @end deftypefn

function retval = save_csv(rfvp, outfile, varargout)
  if ! nargin
    print_usage();
  endif
  fs = 10e3; # サンプリング周波数 [Hz] 三光社 F.G.
  v_pattern = vs_time(rfvp, "frequency", fs);
  retval = bit_with_control_v(control_v_for_rf_amplitude(v_pattern));
  csvwrite(outfile, retval(:))
endfunction

%!test
%! func_name(x)
