## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
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

function retval = subsref(x, s)
  if (isempty(s))
    error("missing index");
  endif
  
  switch s(1).type
    case "()"
    case "{}"
    case "."
      fld = s.subs;
      switch fld
        case "vs_time"
          arg1 = s(2).subs{1};
          t = x.data(1,:);
          if ismatrix(arg1)
            tmsec = arg1;
          else
            switch arg1
              case "interval"
                ts = s(2).subs{2}; # in msec
              case "frequency"
                ts = 1e3/s(2).subs{2}; #in Hz
              otherwise
                error("unsupported arguments");
                disp(s(2).subs);
            endswitch
            tmsec = 0:ts:t(end);
          endif
          t = x.data(1,:);
          for n = 2:length(t)
            t(n) += t(n-1);
          endfor
          retval = interp1(t, x.data(2,:), tmsec, "linear");
          return
#        case "fdB"
#          retval = [x.frequency(:), 20*log10(amp(x))(:)];
#        case "xy"
#          retval = [x.frequency(:), amp(x)(:)];
#        case {"amp", "amplitude"}
#            retval = amp(x); 
#        case "phase"
#            retval = phase(x);
#        case "freq"
#            retval = x.frequency;
        otherwise
          retval = x.(fld);
        endswitch
    otherwise
      error("invalid subscript type");
  endswitch
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction

%!test
%! func_name(x)
