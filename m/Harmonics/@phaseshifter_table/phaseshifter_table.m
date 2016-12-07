## -*- texinfo -*-
## @deftypefn {Function File} {@var{pstable} = } phaseshifter_table{@var{f1}, @var{df1}; @var{f2}, @var{df2}; ...}
## @deftypefnx {Function File} {@var{pstable} =} phaseshifter_table(@var{saved_file})
##
## @strong{Inputs}
## @table @var
## @item f1
## frequency in MHz
## @item df1
## a column wise matrix of [control voltage, phase shift in radius]
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function retval = phaseshifter_table(varargin)
  if ! nargin
    print_usage();
  endif
  if ischar(varargin{1})
    load(file_in_loadpath(varargin{1}));
    retval = pstable;
    return
  endif
  
  argcells = varargin{1};
  freq = cell2mat(argcells(:,1));
  rad_v = cell(length(freq),1);
    
  # 仕様書の移相器特性データにノーマライズ
  phase_shifter = load(file_in_loadpath("PhaseShifter.dat"));
  rad = phase_shifter(:,3);
  v = phase_shifter(:,4);
  ci = cross_interp(v, rad);
  vlist = linspace(v(1), v(end), 200);
  radlist = forward_interp(ci, vlist);
  for n = 1:rows(argcells)
    rfdata = argcells{n,2};
    pmctrlv = rfdata.ctrlv;
    rad0 = forward_interp(ci, pmctrlv(1));
    rad_v{n} = [pmctrlv, rfdata.phis - (rfdata.phis(1) - rad0)];
  endfor
  rad_v0 = struct("points", [v, rad], "line", [vlist, radlist]);
  s = tars(freq, rad_v, rad_v0);
  retval = class(s, "phaseshifter_table");
endfunction

