## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} harmonics_control(@var{A2PM2file}, @var{phase_shifter_data},["ignore_freq_response_of_ps"])
##
## Make an object to evaluate control voltage pattern for the Harmonics Controller.
##
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

function self = harmonics_control(A2PM2file, pstablefile, varargin)
  if ! nargin
    print_usage();
    return;
  endif
  opts = get_properties(varargin, {"ignore_freq_response_of_ps", false});
  
  # 高調波ゼロ位相の周波数特性
  A2_PM2 = csvread(file_in_loadpath(A2PM2file));
  A2_PM2(1,:) = [];
  fHz = A2_PM2(:,2);
  a2 = A2_PM2(:,3);
  pm2 = A2_PM2(:,4);
  ci_phase_base = cross_interp(fHz, pm2);
  ci_amp = cross_interp(fHz, a2);
  
  s = tars(ci_phase_base, ci_amp);
  # 移相器特性
  if opts.ignore_freq_response_of_ps
    pscurve = phaseshifter_polycurve(pstablefile);
    s = append_fields(s, pscurve);
  else
    pstable = phaseshifter_table(pstablefile);
    s = append_fields(s, pstable);
  endif  
  self._properties = s;
  self = class(self, "harmonics_control");
endfunction
