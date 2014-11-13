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
## 2014-11-13
## * added .ts (sampling interval)
## 2012-10-16
## * initial implementation

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
        case "ts" # sampling interval
          retval = str2num(x.preambles("XIN"))
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
