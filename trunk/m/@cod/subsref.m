## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{cod})
## 
## @end deftypefn

##== History
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
      retval = x.(fld);
    otherwise
      error("invalid subscript type");
  endswitch
  
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction

%!test
%! func_name(x)
