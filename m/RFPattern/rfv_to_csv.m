## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} rfv_to_csv(@var{rfv}, ["outfile", @var{outfile}, "fs", @var{fs}])
## save RF Pattern date into a CSV file for the Sankosha's function generator.
## @strong{Inputs}
## @table @var
## @item rfv
## pattern date of RF voltage pattern.
## [dt1, dt2, ... ; v1, v2, ...] 
## @item csvfile
## if omitted, variable name of @var{rfv} will be used for the output filename. 
## @item fs
## sampling rate in Hz.
## @end table
##
## @end deftypefn

function retval = rfv_to_csv(rfv, varargin)
  if ! nargin
    print_usage();
  endif
  
  opts = get_properties(varargin, {"outfile", NA, "fs", 10e3});
  ts = 1/opts.fs;

  t_msec = (0:ts:2)*1e3;
  v_pattern = rfvoltage_for_times(rfv, t_msec);
  v_in_bit = bit_with_control_v(control_v_for_rf_amplitude(v_pattern));
  if ischar(opts.outfile)
    outfile = opts.outfile;
  else
    outfile= [inputname(1), ".csv"];
  endif
  csvwrite(outfile, v_in_bit(:));
endfunction

%!test
%! func_name(x)
