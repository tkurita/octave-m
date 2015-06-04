## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} vs_time(@var{arg})
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

function retval = vs_time(rfv, varargin)
  if ! nargin
    print_usage();
  endif
  arg1 = varargin{1};
  t = rfv.pattern(1,:);
  if isnumeric(arg1)
    tmsec = arg1;
  else
    switch arg1
      case "interval"
        ts = varargin{2}; # in msec
      case "frequency"
        ts = 1e3/varargin{2}; #in Hz
      otherwise
        error("unsupported arguments");
        disp(s(2).subs);
    endswitch
    tmsec = 0:ts:t(end);
  endif
  t = rfv.pattern(1,:);
  for n = 2:length(t)
    t(n) += t(n-1);
  endfor
  retval = interp1(t, rfv.pattern(2,:), tmsec, "linear");
  #plot(retval)
endfunction

%!test
%! func_name(x)
