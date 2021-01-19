## -- retval = func_name(arg1, arg2)
##     description
##
##  * Inputs *
##    arg1 : 
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

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
