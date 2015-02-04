## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
## 
## isfdata.v returns values in units of volt.
##
## isfdata.preambles returns preambles of isf file as a dict object.
##
## isfdata.preambles("name") returns a value of "name" entry in the preambles.
##
## @end deftypefn

##== History
## 2015-02-04
## * subscription "xy" returns [frequency, amplitude]. 
##   amplituede is not passed through log10.
## 2014-12-23
## * added "fdB".
## 2014-11-17
## * first implementation

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
        case {"fdBm", "fdB"} # sampling interval
          retval = [x.frequency(:), 20*log10(x.amplitude)(:)];
        case "xy"
          retval = [x.frequency(:), x.amplitude(:)];
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
